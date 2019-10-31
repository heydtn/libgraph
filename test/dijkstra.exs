defmodule GraphTest do
  use ExUnit.Case, async: true
  alias Graph.Edge
  alias Graph.Test.Generators

  test "shortest path for complex graph using float weights" do
    g = build_complex_graph_float()

    g = build_complex_graph()

    shortest_g = Graph.Pathfinding.dijkstra(g, "start")

    {:ok, result} = Graph.Serializers.DOT.serialize(g)
    {:ok, result2} = Graph.Serializers.DOT.serialize(shortest_g)
    File.write("./dotfile.dot", result)
    File.write("./dotfile2.dot", result2)

    assert shortest_g ==
             [
               "start",
               "start_0",
               96,
               97,
               98,
               33,
               100,
               34,
               35,
               36,
               37,
               19,
               65,
               66,
               67,
               "end_0",
               "end"
             ]
  end

  defp build_basic_cyclic_graph do
    Graph.new()
    |> Graph.add_vertex(:a)
    |> Graph.add_vertex(:b)
    |> Graph.add_vertex(:c)
    |> Graph.add_vertex(:d)
    |> Graph.add_vertex(:e)
    |> Graph.add_edge(:a, :b)
    |> Graph.add_edge(:a, :c)
    |> Graph.add_edge(:b, :c)
    |> Graph.add_edge(:b, :d)
    |> Graph.add_edge(:c, :d)
    |> Graph.add_edge(:c, :a)
    |> Graph.add_edge(:d, :e)
  end

  defp build_basic_cyclic_digraph do
    dg = :digraph.new()
    :digraph.add_vertex(dg, :a)
    :digraph.add_vertex(dg, :b)
    :digraph.add_vertex(dg, :c)
    :digraph.add_vertex(dg, :d)
    :digraph.add_vertex(dg, :e)
    :digraph.add_edge(dg, :a, :b)
    :digraph.add_edge(dg, :a, :c)
    :digraph.add_edge(dg, :b, :c)
    :digraph.add_edge(dg, :b, :d)
    :digraph.add_edge(dg, :c, :d)
    :digraph.add_edge(dg, :c, :a)
    :digraph.add_edge(dg, :d, :e)
    dg
  end

  defp build_basic_acyclic_graph do
    Graph.new()
    |> Graph.add_vertex(:a)
    |> Graph.add_vertex(:b)
    |> Graph.add_vertex(:c)
    |> Graph.add_vertex(:d)
    |> Graph.add_vertex(:e)
    |> Graph.add_edge(:a, :b)
    |> Graph.add_edge(:a, :c)
    |> Graph.add_edge(:b, :c)
    |> Graph.add_edge(:b, :d)
    |> Graph.add_edge(:c, :d)
    |> Graph.add_edge(:d, :e)
  end

  defp build_basic_acyclic_digraph do
    dg = :digraph.new()
    :digraph.add_vertex(dg, :a)
    :digraph.add_vertex(dg, :b)
    :digraph.add_vertex(dg, :c)
    :digraph.add_vertex(dg, :d)
    :digraph.add_vertex(dg, :e)
    :digraph.add_edge(dg, :a, :b)
    :digraph.add_edge(dg, :a, :c)
    :digraph.add_edge(dg, :b, :c)
    :digraph.add_edge(dg, :b, :d)
    :digraph.add_edge(dg, :c, :d)
    :digraph.add_edge(dg, :d, :e)
    dg
  end

  defp build_basic_tree_graph do
    Graph.new()
    |> Graph.add_vertex(:a)
    |> Graph.add_vertex(:b)
    |> Graph.add_vertex(:c)
    |> Graph.add_vertex(:d)
    |> Graph.add_vertex(:e)
    |> Graph.add_edge(:a, :b)
    |> Graph.add_edge(:b, :c)
    |> Graph.add_edge(:c, :d)
    |> Graph.add_edge(:c, :e)
  end

  defp build_basic_tree_digraph do
    dg = :digraph.new()
    :digraph.add_vertex(dg, :a)
    :digraph.add_vertex(dg, :b)
    :digraph.add_vertex(dg, :c)
    :digraph.add_vertex(dg, :d)
    :digraph.add_vertex(dg, :e)
    :digraph.add_edge(dg, :a, :b)
    :digraph.add_edge(dg, :b, :c)
    :digraph.add_edge(dg, :c, :d)
    :digraph.add_edge(dg, :c, :e)
    dg
  end

  defp build_basic_undirected_graph do
    Graph.new(type: :undirected)
    |> Graph.add_vertices([:a, :b, :c])
    |> Graph.add_edge(:a, :b)
    |> Graph.add_edge(:c, :b)
  end

  defp build_complex_graph() do
    Graph.new()
    |> Graph.add_edge(42, 25, weight: 2525)
    |> Graph.add_edge(66, 67, weight: 2254)
    |> Graph.add_edge(71, 72, weight: 3895)
    |> Graph.add_edge(79, 80, weight: 37236)
    |> Graph.add_edge(0, 1, weight: 1573)
    |> Graph.add_edge(0, 64, weight: 1595)
    |> Graph.add_edge(30, 31, weight: 518)
    |> Graph.add_edge(58, 56, weight: 431)
    |> Graph.add_edge(58, 60, weight: 468)
    |> Graph.add_edge(58, 47, weight: 1175)
    |> Graph.add_edge(23, 24, weight: 1807)
    |> Graph.add_edge(50, 56, weight: 1192)
    |> Graph.add_edge(50, 49, weight: 198)
    |> Graph.add_edge(50, 57, weight: 1192)
    |> Graph.add_edge(22, 23, weight: 1919)
    |> Graph.add_edge(22, 91, weight: 4032)
    |> Graph.add_edge(43, 44, weight: 255)
    |> Graph.add_edge(60, 46, weight: 1167)
    |> Graph.add_edge(60, 55, weight: 159)
    |> Graph.add_edge(60, 58, weight: 468)
    |> Graph.add_edge(36, 37, weight: 9132)
    |> Graph.add_edge(75, 77, weight: 2120)
    |> Graph.add_edge(14, 15, weight: 3483)
    |> Graph.add_edge(32, 33, weight: 1008)
    |> Graph.add_edge(41, 20, weight: 2271)
    |> Graph.add_edge(101, 102, weight: 27752)
    |> Graph.add_edge(102, 104, weight: 44964)
    |> Graph.add_edge(102, 103, weight: 1287)
    |> Graph.add_edge(104, 78, weight: 944)
    |> Graph.add_edge(85, 86, weight: 3029)
    |> Graph.add_edge(72, 73, weight: 2872)
    |> Graph.add_edge(88, 89, weight: 7817)
    |> Graph.add_edge(103, 92, weight: 2884)
    |> Graph.add_edge(69, 70, weight: 1719)
    |> Graph.add_edge(69, 21, weight: 3059)
    |> Graph.add_edge(13, 14, weight: 3002)
    |> Graph.add_edge(84, 85, weight: 3735)
    |> Graph.add_edge(48, 47, weight: 204)
    |> Graph.add_edge(34, 35, weight: 6487)
    |> Graph.add_edge(80, 90, weight: 29876)
    |> Graph.add_edge(80, 103, weight: 2047)
    |> Graph.add_edge(95, "start_0", weight: 3130)
    |> Graph.add_edge(49, 50, weight: 198)
    |> Graph.add_edge(38, 39, weight: 11222)
    |> Graph.add_edge(37, 19, weight: 5284)
    |> Graph.add_edge(68, 69, weight: 2476)
    |> Graph.add_edge(77, 78, weight: 2138)
    |> Graph.add_edge(86, 87, weight: 8289)
    |> Graph.add_edge(61, 64, weight: 508)
    |> Graph.add_edge(61, 46, weight: 1181)
    |> Graph.add_edge(61, 59, weight: 490)
    |> Graph.add_edge("end_0", 68, weight: 288)
    |> Graph.add_edge("end_0", "end", weight: 0)
    |> Graph.add_edge(87, 88, weight: 5729)
    |> Graph.add_edge(94, 95, weight: 2665)
    |> Graph.add_edge(74, 75, weight: 1641)
    |> Graph.add_edge(12, 13, weight: 5014)
    |> Graph.add_edge(25, 30, weight: 1645)
    |> Graph.add_edge(25, 24, weight: 248)
    |> Graph.add_edge(15, 1, weight: 2005)
    |> Graph.add_edge(4, 12, weight: 3150)
    |> Graph.add_edge(54, 56, weight: 547)
    |> Graph.add_edge(54, 52, weight: 1332)
    |> Graph.add_edge(54, 27, weight: 2095)
    |> Graph.add_edge(70, 71, weight: 22390)
    |> Graph.add_edge(29, 32, weight: 2449)
    |> Graph.add_edge(59, 47, weight: 1190)
    |> Graph.add_edge(59, 57, weight: 418)
    |> Graph.add_edge(59, 61, weight: 490)
    |> Graph.add_edge(35, 36, weight: 6814)
    |> Graph.add_edge(52, 51, weight: 195)
    |> Graph.add_edge(52, 54, weight: 1332)
    |> Graph.add_edge(52, 55, weight: 1186)
    |> Graph.add_edge("start", "start_0", weight: 0)
    |> Graph.add_edge(78, 84, weight: 3418)
    |> Graph.add_edge(78, 79, weight: 6596)
    |> Graph.add_edge("start_0", 96, weight: 120)
    |> Graph.add_edge(39, 93, weight: 4220)
    |> Graph.add_edge(39, 40, weight: 5082)
    |> Graph.add_edge(45, 46, weight: 235)
    |> Graph.add_edge(18, 29, weight: 600)
    |> Graph.add_edge(73, 74, weight: 788)
    |> Graph.add_edge(98, 41, weight: 2187)
    |> Graph.add_edge(98, 33, weight: 1496)
    |> Graph.add_edge(93, 94, weight: 13132)
    |> Graph.add_edge(20, 42, weight: 566)
    |> Graph.add_edge(67, "end_0", weight: 483)
    |> Graph.add_edge(64, 0, weight: 1595)
    |> Graph.add_edge(64, 44, weight: 1174)
    |> Graph.add_edge(64, 61, weight: 508)
    |> Graph.add_edge(96, 13, weight: 2865)
    |> Graph.add_edge(96, 97, weight: 2773)
    |> Graph.add_edge(46, 60, weight: 1167)
    |> Graph.add_edge(46, 45, weight: 235)
    |> Graph.add_edge(46, 61, weight: 1181)
    |> Graph.add_edge(19, 70, weight: 2732)
    |> Graph.add_edge(19, 65, weight: 1911)
    |> Graph.add_edge(65, 66, weight: 2886)
    |> Graph.add_edge(51, 52, weight: 195)
    |> Graph.add_edge(33, 100, weight: 4369)
    |> Graph.add_edge(89, 21, weight: 3165)
    |> Graph.add_edge(89, 65, weight: 3221)
    |> Graph.add_edge(1, 0, weight: 1573)
    |> Graph.add_edge(1, 3, weight: 1999)
    |> Graph.add_edge(100, 93, weight: 2056)
    |> Graph.add_edge(100, 34, weight: 4038)
    |> Graph.add_edge(55, 60, weight: 159)
    |> Graph.add_edge(55, 52, weight: 1186)
    |> Graph.add_edge(55, 57, weight: 358)
    |> Graph.add_edge(21, 38, weight: 16458)
    |> Graph.add_edge(40, 41, weight: 5104)
    |> Graph.add_edge(3, 4, weight: 3476)
    |> Graph.add_edge(91, 22, weight: 4032)
    |> Graph.add_edge(91, 101, weight: 1970)
    |> Graph.add_edge(44, 64, weight: 1174)
    |> Graph.add_edge(44, 57, weight: 1129)
    |> Graph.add_edge(44, 43, weight: 255)
    |> Graph.add_edge(24, 22, weight: 1820)
    |> Graph.add_edge(24, 25, weight: 248)
    |> Graph.add_edge(27, 54, weight: 2095)
    |> Graph.add_edge(27, 29, weight: 1205)
    |> Graph.add_edge(57, 44, weight: 1129)
    |> Graph.add_edge(57, 50, weight: 1192)
    |> Graph.add_edge(57, 55, weight: 358)
    |> Graph.add_edge(57, 59, weight: 418)
    |> Graph.add_edge(92, 38, weight: 3589)
    |> Graph.add_edge(47, 48, weight: 204)
    |> Graph.add_edge(47, 59, weight: 1190)
    |> Graph.add_edge(47, 58, weight: 1175)
    |> Graph.add_edge(56, 50, weight: 1192)
    |> Graph.add_edge(56, 54, weight: 547)
    |> Graph.add_edge(56, 58, weight: 431)
    |> Graph.add_edge(90, 91, weight: 2301)
    |> Graph.add_edge(31, 18, weight: 861)
    |> Graph.add_edge(31, 27, weight: 1178)
    |> Graph.add_edge(97, 98, weight: 13465)
  end

  defp build_complex_graph_float do
    build_complex_graph()
    |> Graph.edges()
    |> Enum.reduce(Graph.new(), fn %Graph.Edge{weight: weight} = edge, acc ->
      acc
      |> Graph.add_edge(%Graph.Edge{edge | weight: weight / 1000})
    end)
  end
end

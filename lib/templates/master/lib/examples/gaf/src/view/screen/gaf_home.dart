part of gaf_example;

class GafHome extends AbstractReflowScreen {
  GafHome(String id) : super(id) {}

  //----------------------------------------------------------------------------

  @override
  void init({Map<String, String> params: null}) {
    super.init(params: params);

    // your initialization operations here

    addChild(reflow);

    onInitComplete();
  }

  //----------------------------------------------------------------------------

  @override
  void refresh() {
    super.refresh();

    // your redraw operations here
  }

  //----------------------------------------------------------------------------

  @override
  void dispose({bool removeSelf: true}) {
    // your cleanup operations here

    Rd.JUGGLER.removeTweens(this);
    super.dispose();
  }

  //----------------------------------------------------------------------------
}

From: robh@kernel.org (Rob Herring)
Date: Wed, 6 Dec 2017 15:56:13 -0600
Subject: [PATCH v3 01/15] dt-bindings: panel: lvds: Document power-supply
 property
In-Reply-To: <97ebf0615821d79e8d7718594fe3a542a743a05f.1512486553.git-series.maxime.ripard@free-electrons.com>
References: <cover.825a49a4c1c565a548f3de0375e7537e7e8fd3a4.1512486553.git-series.maxime.ripard@free-electrons.com>
 <97ebf0615821d79e8d7718594fe3a542a743a05f.1512486553.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20171206215613.xgedrjdeteqm6km5@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 05, 2017 at 04:10:13PM +0100, Maxime Ripard wrote:
> The power-supply property is used by a vast majority of panels, including
> panel-simple. Let's document it as a common property
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/display/panel/panel-common.txt | 6 ++++++
>  Documentation/devicetree/bindings/display/panel/panel-lvds.txt   | 1 +
>  Documentation/devicetree/bindings/display/panel/simple-panel.txt | 2 +-
>  3 files changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>

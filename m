From: robh@kernel.org (Rob Herring)
Date: Tue, 18 Oct 2016 07:43:49 -0500
Subject: [PATCH v2 6/9] dt-bindings: pinctrl: Deprecate sunxi pinctrl
 bindings
In-Reply-To: <ee6d214a14ed31689c5f70fc6ee5736c3d26737b.1476200742.git-series.maxime.ripard@free-electrons.com>
References: <cover.7edc6c25be8a5e2efdda6a82e102dbf7ece6aa64.1476200742.git-series.maxime.ripard@free-electrons.com>
 <ee6d214a14ed31689c5f70fc6ee5736c3d26737b.1476200742.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20161018124349.qxsrpx3yjy62bqhp@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2016 at 05:46:04PM +0200, Maxime Ripard wrote:
> The generic pin configuration and multiplexing should be preferred now,
> even though we still support the old one.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+), 0 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

From: robh@kernel.org (Rob Herring)
Date: Tue, 14 Aug 2018 14:15:02 -0600
Subject: [v0.1 PATCH 3/7] dt-bindings: mmc: add DT binding for UniPhier
 SD/eMMC controller
In-Reply-To: <1533622642-13989-4-git-send-email-yamada.masahiro@socionext.com>
References: <1533622642-13989-1-git-send-email-yamada.masahiro@socionext.com>
 <1533622642-13989-4-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20180814201502.GA26094@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  7 Aug 2018 15:17:18 +0900, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> This SD/eMMC controller is used for UniPhier SoC family.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  .../devicetree/bindings/mmc/uniphier-sd.txt        | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/uniphier-sd.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

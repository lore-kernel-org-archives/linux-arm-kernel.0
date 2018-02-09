From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 9 Feb 2018 18:14:08 -0200
Subject: [PATCH 2/3] dt-bindings: regulator: describe da9062's regulator
 modes
In-Reply-To: <1518170721-28198-3-git-send-email-chf.fritz@googlemail.com>
References: <1518170721-28198-1-git-send-email-chf.fritz@googlemail.com>
 <1518170721-28198-3-git-send-email-chf.fritz@googlemail.com>
Message-ID: <CAOMZO5B+SB3-sbvts88+geaqRTLMX9r0vtzw7hodP1FdNys8=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 9, 2018 at 8:05 AM, Christoph Fritz
<chf.fritz@googlemail.com> wrote:
> This patch adds DT description of da9062's buck regulator modes.
>
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> ---
>  Documentation/devicetree/bindings/mfd/da9062.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documentation/devicetree/bindings/mfd/da9062.txt
> index c0a418c..b871bc2 100644
> --- a/Documentation/devicetree/bindings/mfd/da9062.txt
> +++ b/Documentation/devicetree/bindings/mfd/da9062.txt
> @@ -64,6 +64,14 @@ Sub-nodes:
>      ldo3     : LDO_3
>      ldo4     : LDO_4
>
> +  The DA9062 regulators optionally support setting "regulator-initial-mode"

It would be clearer if this text goes into a "Optional Properties" section.

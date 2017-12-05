From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 5 Dec 2017 12:13:36 -0200
Subject: [PATCH v2 2/5] ARM: dts: imx53: add srtc node
In-Reply-To: <20171205140646.30367-3-linux-kernel-dev@beckhoff.com>
References: <20171205140646.30367-1-linux-kernel-dev@beckhoff.com>
 <20171205140646.30367-3-linux-kernel-dev@beckhoff.com>
Message-ID: <CAOMZO5DiRa1aLFHiFv_-_3J9LLuq-J06FHLQ4o7=r8hrftEpqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 5, 2017 at 12:06 PM,  <linux-kernel-dev@beckhoff.com> wrote:

>                         srtc: srtc at 53fa4000 {
> -                               compatible = "fsl,imx53-rtc", "fsl,imx25-rtc";
> +                               compatible = "fsl,imx53-rtc";
>                                 reg = <0x53fa4000 0x4000>;
>                                 interrupts = <24>;
> -                               interrupt-parent = <&tzic>;
>                                 clocks = <&clks IMX5_CLK_SRTC_GATE>;
> -                               clock-names = "ipg";

srtc node has been removed in linux-next.

You need to re-add it.

From: julian.calaby@gmail.com (Julian Calaby)
Date: Sun, 17 Sep 2017 12:35:37 +1000
Subject: [linux-sunxi] [PATCH 3/4] arm64: allwinner: h5: add compatible
 string for DE2 CCU
In-Reply-To: <20170911155529.62891-4-icenowy@aosc.io>
References: <20170911155529.62891-1-icenowy@aosc.io>
 <20170911155529.62891-4-icenowy@aosc.io>
Message-ID: <CAGRGNgVNTvUtu47dQafHkRrW8wQDyT84NTZ=sWT+S3o6zpwAog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Icenowy,

On Tue, Sep 12, 2017 at 1:55 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
> The DE2 CCU on Allwinner H5 SoC has a slightly different behavior than
> the one on H3, so the compatible string is not set in the common DTSI
> file.
>
> Add the compatible string of H5 DE2 CCU in H5 DTSI file.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> index d9a720bff05d..e237c05cfdb4 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> @@ -98,6 +98,10 @@
>         compatible = "allwinner,sun50i-h5-ccu";
>  };
>
> +&display_clocks {
> +       compatible = "allwinner,sun50i-h5-de2-clk";
> +};
> +

This is what I get for reviewing before reading the full patch set.

Shouldn't this be rolled into the previous patch?

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

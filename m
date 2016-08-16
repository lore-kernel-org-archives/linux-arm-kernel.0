From: robh@kernel.org (Rob Herring)
Date: Tue, 16 Aug 2016 07:56:24 -0500
Subject: [PATCH v2 1/2] devicetree: Add vendor prefix for Shenzhen
 Sunchip Technology Co., Ltd
In-Reply-To: <bae6ad6c04f7567b224e008ab27b32d2dac1d9c1.1471125083.git.ccc94453@vip.cybercity.dk>
References: <20160812235312.GB10557@vip.cybercity.dk>
 <bae6ad6c04f7567b224e008ab27b32d2dac1d9c1.1471125083.git.ccc94453@vip.cybercity.dk>
Message-ID: <20160816125624.GA20716@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 11, 2016 at 10:11:51PM +0200, Rask Ingemann Lambertsen wrote:
> Shenzhen Sunchip Technology Co., Ltd produces TV boxes and TV dongles,
> some of which are sold under other brands. Website:
> <URL:http://www.sunchip-tech.com/>
> 
> Signed-off-by: Rask Ingemann Lambertsen <ccc94453@vip.cybercity.dk>
> ---
> Changes in v2:
> No patch changes, but added CC to the ARM kernel mailing list.
> 
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 1992aa9..fbad2cea 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -256,6 +256,7 @@ ste	ST-Ericsson
>  stericsson	ST-Ericsson
>  syna	Synaptics Inc.
>  synology	Synology, Inc.
> +sunchip	Shenzhen Sunchip Technology Co., Ltd
>  SUNW	Sun Microsystems, Inc

These are not in alphabetical order. Maybe someone thought uppercase 
should be separate, but I don't. So please fix the ordering here moving 
SUNW before syna.

Rob

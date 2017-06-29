From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 29 Jun 2017 14:59:31 +0300
Subject: [PATCH 5/5] ARM: dts: sama5d27_som1_ek: Add sama5d27 SoM1 EK
 support
In-Reply-To: <1498736674-9233-6-git-send-email-claudiu.beznea@microchip.com>
References: <1498736674-9233-1-git-send-email-claudiu.beznea@microchip.com>
 <1498736674-9233-6-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <20170629115931.yki2xbehyicbtx3w@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Claudiu,

On Thu, Jun 29, 2017 at 02:44:34PM +0300, Claudiu Beznea wrote:
> Add specifig DTS files and bindings for sama5d27 SoM1 EK board.

Is there any publicly available information on this SoM?

One more comment below.

> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> ---

[snip]

> +	memory {
> +		reg = <0x20000000 0x20000>;

Are you sure this SoM has 132KB RAM?

Since you seem to rely on the bootloader to fill in the right size value, you 
can just drop this node and rely on sama5d2.dtsi that provides a stub node.

> +	};

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

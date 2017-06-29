From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 29 Jun 2017 14:16:55 +0200
Subject: [PATCH 5/5] ARM: dts: sama5d27_som1_ek: Add sama5d27 SoM1 EK
 support
In-Reply-To: <20170629115931.yki2xbehyicbtx3w@tarshish>
References: <1498736674-9233-1-git-send-email-claudiu.beznea@microchip.com>
 <1498736674-9233-6-git-send-email-claudiu.beznea@microchip.com>
 <20170629115931.yki2xbehyicbtx3w@tarshish>
Message-ID: <20170629121655.37pq7cnabvv4wh7z@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/06/2017 at 14:59:31 +0300, Baruch Siach wrote:
> Hi Claudiu,
> 
> On Thu, Jun 29, 2017 at 02:44:34PM +0300, Claudiu Beznea wrote:
> > Add specifig DTS files and bindings for sama5d27 SoM1 EK board.
> 
> Is there any publicly available information on this SoM?
> 
> One more comment below.
> 
> > Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> > Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> > ---
> 
> [snip]
> 
> > +	memory {
> > +		reg = <0x20000000 0x20000>;
> 
> Are you sure this SoM has 132KB RAM?
> 
> Since you seem to rely on the bootloader to fill in the right size value, you 
> can just drop this node and rely on sama5d2.dtsi that provides a stub node.
> 

Yeah, that is what I would do too.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 14 Apr 2014 14:53:09 +0200
Subject: [PATCH 3/6] ARM: dts: zynq: drop address cells from GIC node
In-Reply-To: <f0de762f-56b3-4894-aa78-7ca3c88b9e28@AM1EHSMHS004.ehs.local>
References: <1397228380-7352-1-git-send-email-l.stach@pengutronix.de>
 <1397228380-7352-3-git-send-email-l.stach@pengutronix.de>
 <f0de762f-56b3-4894-aa78-7ca3c88b9e28@AM1EHSMHS004.ehs.local>
Message-ID: <1397479989.4548.26.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi S?ren,

Am Freitag, den 11.04.2014, 08:54 -0700 schrieb S?ren Brinkmann:
> On Fri, 2014-04-11 at 04:59PM +0200, Lucas Stach wrote:
> > This is likely a copy-and-paste error from the
> > ARM GIC documentation, that has already been fixed.
> > 
> > address-cells should have been set to 0, as with the size
> > cells. As having those properties set to 0 is the
> > same thing as not specifying them, drop them completely.
> 
> Isn't this property inherited from the parent node, requiring to
> actually set them to 0 to comply with the docs?
> 

No, it isn't. From ePAPR v1.1 section 2.3.5:
"The #address-cells and #size-cells properties are not inherited from
ancestors in the device tree. They shall be explicitly defined."

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

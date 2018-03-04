From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 4 Mar 2018 15:19:28 +0200
Subject: [PATCH 2/2] ARM: dts: armada388-clearfog: add SFP module support
In-Reply-To: <20180304124905.GF9418@n2100.armlinux.org.uk>
References: <20180227160135.GU9418@n2100.armlinux.org.uk>
 <E1eqhha-0004l3-Rd@rmk-PC.armlinux.org.uk>
 <20180304121324.ut3d3i2vpdopae7o@sapphire.tkos.co.il>
 <20180304124905.GF9418@n2100.armlinux.org.uk>
Message-ID: <20180304131928.pxm545alwhmf5u6j@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Sun, Mar 04, 2018 at 12:49:06PM +0000, Russell King - ARM Linux wrote:
> On Sun, Mar 04, 2018 at 02:13:24PM +0200, Baruch Siach wrote:
> > On Tue, Feb 27, 2018 at 04:02:02PM +0000, Russell King wrote:
> > > Add SFP module support for Clearfog using the SFP phylink support.
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > Tested-by: Baruch Siach <baruch@tkos.co.il>
> > 
> > Tested on Clearfog base with kernel version 4.16-rc3. The SFP module is 1G 
> > copper Linktel LX1801CNR.
> 
> Thanks for testing.
> 
> Please also send the "ethtool -m eth2 raw on > foo.bin" output as well
> so I can build a database of module EEPROMs, which allows me to validate
> the SFP parsing code against.  Alternatively, please send the "hex on"
> if you think that's more convenient.

Here are both. Binary file md5sum: 3635c7ceff2127d4d6bf04339b657440

Offset		Values
------		------
0x0000:		03 04 00 00 00 00 08 00 00 00 00 01 0d 00 00 00 
0x0010:		00 00 64 00 4c 49 4e 4b 54 45 4c 20 20 20 20 20 
0x0020:		20 20 20 20 00 00 00 00 4c 58 31 38 30 31 43 4e 
0x0030:		52 20 20 20 20 20 20 20 31 2e 30 20 00 00 00 94 
0x0040:		00 10 00 00 31 31 37 32 36 32 33 39 32 37 20 20 
0x0050:		20 20 20 20 31 37 30 36 32 38 20 20 00 00 00 50 
0x0060:		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
0x0070:		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
0x0080:		ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0x0090:		ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0x00a0:		ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0x00b0:		ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0x00c0:		ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0x00d0:		ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0x00e0:		ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0x00f0:		ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sfp.bin
Type: application/octet-stream
Size: 256 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180304/77a629b6/attachment.bin>

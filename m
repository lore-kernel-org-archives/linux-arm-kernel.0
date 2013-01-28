From: balbi@ti.com (Felipe Balbi)
Date: Mon, 28 Jan 2013 18:51:59 +0200
Subject: OMAP baseline test results for v3.8-rc5
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EAF78AE@DBDE01.ent.ti.com>
References: <alpine.DEB.2.00.1301260838300.19277@utopia.booyaka.com>
 <20130126084604.GB8754@arwen.pp.htv.fi>
 <C8443D0743D26F4388EA172BF4E2A7A93EA9456A@DBDE01.ent.ti.com>
 <20130128113818.GD28698@arwen.pp.htv.fi>
 <C8443D0743D26F4388EA172BF4E2A7A93EA946E4@DBDE01.ent.ti.com>
 <20130128121635.GI28698@arwen.pp.htv.fi>
 <C8443D0743D26F4388EA172BF4E2A7A93EA94745@DBDE01.ent.ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EAF78AE@DBDE01.ent.ti.com>
Message-ID: <20130128165159.GZ28698@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 28, 2013 at 03:40:09PM +0100, AnilKumar, Chimata wrote:
> On Mon, Jan 28, 2013 at 17:48:49, Mohammed, Afzal wrote:
> > Hi Felipe,
> > 
> > On Mon, Jan 28, 2013 at 17:46:35, Balbi, Felipe wrote:
> > 
> > > didn't help :-s
> > 
> > Hands up :(
> 
> Hi Felipe,
> 
> Could you please try with any of these options?
> 
> 1. Change/add mem=512M (should be same value as u-boot printed RAM size) in your
> bootargs?
> 
> Or
> 
> 2. set fdt_high 0xffffffff (at u-boot prompt).

that helped, thank you :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130128/4ced70d0/attachment.sig>

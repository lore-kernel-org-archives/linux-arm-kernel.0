From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Mon, 28 Jan 2013 14:40:09 +0000
Subject: OMAP baseline test results for v3.8-rc5
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EA94745@DBDE01.ent.ti.com>
References: <alpine.DEB.2.00.1301260838300.19277@utopia.booyaka.com>
 <20130126084604.GB8754@arwen.pp.htv.fi>
 <C8443D0743D26F4388EA172BF4E2A7A93EA9456A@DBDE01.ent.ti.com>
 <20130128113818.GD28698@arwen.pp.htv.fi>
 <C8443D0743D26F4388EA172BF4E2A7A93EA946E4@DBDE01.ent.ti.com>
 <20130128121635.GI28698@arwen.pp.htv.fi>
 <C8443D0743D26F4388EA172BF4E2A7A93EA94745@DBDE01.ent.ti.com>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EAF78AE@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 17:48:49, Mohammed, Afzal wrote:
> Hi Felipe,
> 
> On Mon, Jan 28, 2013 at 17:46:35, Balbi, Felipe wrote:
> 
> > didn't help :-s
> 
> Hands up :(

Hi Felipe,

Could you please try with any of these options?

1. Change/add mem=512M (should be same value as u-boot printed RAM size) in your
bootargs?

Or

2. set fdt_high 0xffffffff (at u-boot prompt).

Thanks
AnilKumar

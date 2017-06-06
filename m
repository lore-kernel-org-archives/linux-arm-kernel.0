From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Jun 2017 15:46:20 +0100
Subject: [PATCH 0/2] arm64/kvm: use SYS_REG_DESC() for VGIC-v3
In-Reply-To: <20170606134634.GE9464@cbox>
References: <1496668801-16064-1-git-send-email-mark.rutland@arm.com>
 <20170606134634.GE9464@cbox>
Message-ID: <20170606144620.GE4789@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 06, 2017 at 03:46:34PM +0200, Christoffer Dall wrote:
> Hi Mark,
> 
> On Mon, Jun 05, 2017 at 02:19:59PM +0100, Mark Rutland wrote:
> > While looking around, I spotted that the VGIC-v3 code still uses open-coded SYS
> > encodings. These patches migrate said code to use common <asm/sysreg.h>
> > mnemonics, as we do for the rest of the AArch64 sysregs.
> > 
> > This is based on Marc's kvm-arm64/gicv3-cpuif-mediated-access branch [1].
> 
> Patches look good to me.  I can apply them after we apply [1] if
> Catalin/Will are ok with this.

Fine by me.

Acked-by: Will Deacon <will.deacon@arm.com>

if you need it.

Will

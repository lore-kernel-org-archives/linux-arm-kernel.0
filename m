From: geoff@infradead.org (Geoff Levand)
Date: Mon, 22 Sep 2014 14:45:51 -0700
Subject: [PATCH 01/13] arm64: Add ESR_EL2_EC macros to hyp-stub
In-Reply-To: <20140915161014.GB13789@leverpostej>
References: <cover.1410302383.git.geoff@infradead.org>
 <5e1b1892eb3ecc3bccff47766675c24c650a1a14.1410302383.git.geoff@infradead.org>
 <20140915161014.GB13789@leverpostej>
Message-ID: <1411422351.6001.28.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Mark,

On Mon, 2014-09-15 at 17:10 +0100, Mark Rutland wrote:
> On Tue, Sep 09, 2014 at 11:49:04PM +0100, Geoff Levand wrote:
> > +#define ESR_EL2_EC_SHIFT	26
> > +#define ESR_EL2_EC_HVC64	0x16
> 
> These exist in arch/arm64/include/asm/kvm_arm.h, no?
> 
> If anything that should be folded into arch/arm64/include/asm/esr.h...

OK, I'll remove this patch and add the esr.h fixup into my generic
'arm64 enhancements' series.

-Geoff

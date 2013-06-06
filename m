From: bp@alien8.de (Borislav Petkov)
Date: Fri, 7 Jun 2013 00:23:20 +0200
Subject: [PATCH v7] arm: use built-in byte swap function
In-Reply-To: <20130606221234.GQ18614@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.03.1302202327370.6419@syhkavp.arg>
 <20130221005221.15279b1372501af12c1e4f32@freescale.com>
 <alpine.LFD.2.03.1302211134160.6419@syhkavp.arg>
 <20130221203327.6558f89277468f7ffffa6506@freescale.com>
 <alpine.LFD.2.03.1302212219100.6419@syhkavp.arg>
 <20130222194032.f7b44aefa5e2723d16767a1b@freescale.com>
 <1361661654.18110.102.camel@shinybook.infradead.org>
 <20130523114654.1f273241725205c6703b2226@freescale.com>
 <20130523231336.GS18614@n2100.arm.linux.org.uk>
 <20130606221234.GQ18614@n2100.arm.linux.org.uk>
Message-ID: <20130606222320.GT20972@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 06, 2013 at 11:12:34PM +0100, Russell King - ARM Linux wrote:
> That will ultimately then give sfr a conflict which should be trivial
> to resolve - and hopefully we'll find out who's carrying the LZ4 patch
> and putting it into linux-next.

That should be akpm:

http://ozlabs.org/~akpm/mmotm/broken-out/arm-add-support-for-lz4-compressed-kernel.patch

AFAICT.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

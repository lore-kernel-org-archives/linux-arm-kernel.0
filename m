From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Oct 2013 11:44:20 +0100
Subject: [PATCH 3/3] arm64: include: asm: atomic.h: use 'unsigned int'
 and 'atomic_t' instead of 'unsigned long' for atomic_clear_mask()
In-Reply-To: <525751E2.3020207@asianux.com>
References: <52561137.3070608@asianux.com> <5256117A.4000009@asianux.com>
 <5256121A.9030504@asianux.com> <52561269.60900@asianux.com>
 <20131010100733.GH3817@mudshark.cambridge.arm.com>
 <52568998.2080108@asianux.com>
 <20131010142305.GG6199@mudshark.cambridge.arm.com>
 <525751E2.3020207@asianux.com>
Message-ID: <20131011104419.GE14732@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 11, 2013 at 02:18:26AM +0100, Chen Gang wrote:
> On 10/10/2013 10:23 PM, Will Deacon wrote:
> > On Thu, Oct 10, 2013 at 12:03:52PM +0100, Chen Gang wrote:
> >> BTW: do arm64 need atomic_clear_mask()?
> > 
> > No. Neither ARM nor arm64 need this function.
> 
> OK, thank you for your confirmation.
> 
> Hmm... can we remove atomic_clear_mask() from ARM and arm64? (in my
> opinion, if not need, better to remove it).

Yes!

I mentioned this a few times already...

Will

From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 18 Dec 2013 17:29:56 +0000
Subject: [PATCH 0/4] arm64: advertise availability of CRC and crypto
 instructions
In-Reply-To: <CAKv+Gu_zCQkF2hYf_kWiD8mt_S3Due=Wz1SOqw_hBibSkgWtOA@mail.gmail.com>
References: <CAKv+Gu824T1vx=O9taLaDSB-HE3OLSpwnpWMn4z+x8YdmLuM+A@mail.gmail.com>
 <20131218100321.GC4360@n2100.arm.linux.org.uk>
 <CAKv+Gu87zHkxKKyH0-jEcBKcdbWTahN2bgWRDpPog5bds_ukYg@mail.gmail.com>
 <20131218105541.GE4360@n2100.arm.linux.org.uk>
 <CAKv+Gu_M56pXD8N6rANkYWLxXk=iLe3qpwt7zoBo_h6YuBgHTA@mail.gmail.com>
 <20131218112713.GA28112@arm.com>
 <20131218114211.GF4360@n2100.arm.linux.org.uk>
 <20131218120306.GC28112@arm.com> <52B1B0E0.6030104@codeaurora.org>
 <CAKv+Gu_zCQkF2hYf_kWiD8mt_S3Due=Wz1SOqw_hBibSkgWtOA@mail.gmail.com>
Message-ID: <20131218172956.GG28112@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 04:13:52PM +0000, Ard Biesheuvel wrote:
> On 18 December 2013 15:27, Christopher Covington <cov@codeaurora.org> wrote:
> > I do not think that Russell is the source of the confusion. Ard wrote, "The
> > idea is that a binary built for ARM will have access to the extended
> > instructions which ARM64 offers to ARM32 binaries running in 32 bit
> > compatibility mode (such as AES, SHAx etc)." I think s/ARM64/ARMv8/ is
> > necessary to make the statement correct, and hopefully less confusing.
> >
> 
> My apologies for adding to the confusion (or creating it in the first place).
> 
> However, the bottom line is that, as the 32 bit and 64 bit kernels are
> both able to support userland processes running in the execution state
> that has retroactively been dubbed 'AArch32', they should both honor
> the same contract with AArch32 userland on how to discover CPU
> capabilities at runtime.

For the time being, I merged the first two patches for AArch64 support.
I'm not merging the compat one yet as this should strictly follow the
arch/arm support.

Thanks.

-- 
Catalin

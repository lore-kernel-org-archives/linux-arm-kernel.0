From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 19 Dec 2013 11:11:48 +0000
Subject: [PATCH 0/4] arm64: advertise availability of CRC and crypto
 instructions
In-Reply-To: <CAKv+Gu9mzXQ-5V=x=uMmXme6fZCyXvNhYy2oRA1DSkgGjjzYEQ@mail.gmail.com>
References: <CAKv+Gu87zHkxKKyH0-jEcBKcdbWTahN2bgWRDpPog5bds_ukYg@mail.gmail.com>
 <20131218105541.GE4360@n2100.arm.linux.org.uk>
 <CAKv+Gu_M56pXD8N6rANkYWLxXk=iLe3qpwt7zoBo_h6YuBgHTA@mail.gmail.com>
 <20131218112713.GA28112@arm.com>
 <20131218114211.GF4360@n2100.arm.linux.org.uk>
 <20131218120306.GC28112@arm.com> <52B1B0E0.6030104@codeaurora.org>
 <CAKv+Gu_zCQkF2hYf_kWiD8mt_S3Due=Wz1SOqw_hBibSkgWtOA@mail.gmail.com>
 <20131218172956.GG28112@arm.com>
 <CAKv+Gu9mzXQ-5V=x=uMmXme6fZCyXvNhYy2oRA1DSkgGjjzYEQ@mail.gmail.com>
Message-ID: <20131219111147.GA30398@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 06:50:35PM +0000, Ard Biesheuvel wrote:
> On 18 December 2013 18:29, Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> > For the time being, I merged the first two patches for AArch64 support.
> > I'm not merging the compat one yet as this should strictly follow the
> > arch/arm support.
> 
> Yeah, I guess that makes sense.
> 
> I find this ghetto style drive-by veto'ing less than productive,

LOL. That's how we add a bit of excitement to our monotonous maintainer
life ;).

> I would much rather have had an informed discussion involving both
> Russell and you and settle on a solution that is acceptable for both
> ARM and arm64.

I think we first need to get clarification from Russell whether the
problem is the number of hwcap bits used or just not willing to take new
ARMv8/AArch32 features in the 32-bit kernel.

If the latter, we can wait until AArch32 user space people start working
on optimised crypto libraries and restart the discussion at the time.

-- 
Catalin

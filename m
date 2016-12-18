From: ynorov@caviumnetworks.com (Yury Norov)
Date: Sun, 18 Dec 2016 12:38:23 +0530
Subject: [RFC3 nowrap: PATCH v7 00/18] ILP32 for ARM64
In-Reply-To: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20161218070823.GA1153@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 11:32:59PM +0300, Yury Norov wrote:
> This series enables aarch64 with ilp32 mode, and as supporting work,
> introduces ARCH_32BIT_OFF_T configuration option that is enabled for
> existing 32-bit architectures but disabled for new arches (so 64-bit
> off_t is is used by new userspace).
> 
> This version is based on kernel v4.9-rc1.  It works with glibc-2.24,
> and tested with LTP.
 
Hi Arnd, Catalin

For last few days I'm trying to rebase this series on current master,
and I see significant conflicts and regressions. In fact, every time
I rebase on next rc1, I feel like I play a roulette.

This is not a significant problem now because it's almost for sure
that this series will not get into 4.10, for reasons not related to
kernel code. And I have time to deal with regressions. But in general,
I'd like to try my patches on top of other candidates for next merge
window. I cannot read all emails in LKML, but I can easily detect
problems and join to the discussion at early stage if I see any problem.

This is probably a noob question, and there are well-known branches,
like Andrew Morton's one. But at this stage it's very important to
have this series prepared for merge, and I'd prefer to ask about it.

Yury.

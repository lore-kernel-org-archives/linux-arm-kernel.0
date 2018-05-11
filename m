From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 11 May 2018 12:57:47 +0100
Subject: [GIT PULL] arm64: updates for 4.17
In-Reply-To: <CADRPPNQhoXSGr4hpHaomcyamW51wT_F4fRTqZi4qtAD-jBHjxA@mail.gmail.com>
References: <20180404143239.GA18238@arm.com>
 <CADRPPNQhoXSGr4hpHaomcyamW51wT_F4fRTqZi4qtAD-jBHjxA@mail.gmail.com>
Message-ID: <20180511115747.hpryaxa2q357lwki@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2018 at 11:03:18PM -0500, Yang Li wrote:
> On Wed, Apr 4, 2018 at 9:32 AM, Will Deacon <will.deacon@arm.com> wrote:
> > Please pull these arm64 updates for 4.17. Note that I've pulled in a
> > stable branch from Eric Biederman here to fulfil some siginfo dependencies,
> > so the diffstat strays slightly out of arm64 due to his changes.
> {snip}
> >
> > Catalin Marinas (1):
> >       arm64: Revert L1_CACHE_SHIFT back to 6 (64-byte cache line size)
> 
> I'm wondering if we are changing the L1_CACHE_SHIFT to 6 in 4.17?
> This is causing big performance differences for us now.

We pushed it initially but there were some conflicts with the generic
dma work and we had to revert the above commit (so we are back to 7). I
plan to post it again, hopefully in time for 4.18.

-- 
Catalin

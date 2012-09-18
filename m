From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Sep 2012 13:21:11 +0100
Subject: [PATCH 00/15] KVM/ARM Implementation
In-Reply-To: <20120915153359.21241.86002.stgit@ubuntu>
References: <20120915153359.21241.86002.stgit@ubuntu>
Message-ID: <20120918122111.GI32204@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On Sat, Sep 15, 2012 at 04:34:29PM +0100, Christoffer Dall wrote:
> The following series implements KVM support for ARM processors,
> specifically on the Cortex A-15 platform.  We feel this is ready to be
> merged.
> 
> Work is done in collaboration between Columbia University, Virtual Open
> Systems and ARM/Linaro.
> 
> The patch series applies to Linux 3.6-rc5 with a number of merges:
>  1. git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git
>         branch: io (fc8a08c3a3a)

This is a rebasing branch. If you want to merge it, I can push a separate
stable branch for you if you like? That said, I imagine the only patch you
want from there is the non-writeback I/O accessors, so I could just stick
that somewhere else until it hits mainline.

Let me know,

Will

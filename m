From: will.deacon@arm.com (Will Deacon)
Date: Tue, 2 Oct 2012 10:13:01 +0100
Subject: [PATCH] ARM: hw_breakpoint: Clear breakpoints before enabling
 monitor mode
In-Reply-To: <506A3694.4070004@codeaurora.org>
References: <1348160260-19486-1-git-send-email-sboyd@codeaurora.org>
 <20120920173556.GQ4654@mudshark.cambridge.arm.com>
 <20120924171934.GE5522@mudshark.cambridge.arm.com>
 <506A3694.4070004@codeaurora.org>
Message-ID: <20121002091301.GA8847@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 02, 2012 at 01:34:28AM +0100, Stephen Boyd wrote:
> On 09/24/12 10:19, Will Deacon wrote:
> > Ok, I've pushed a bunch of patches to my hw-breakpoint branch (head commit
> > 55cb726797c7). I'll post them to the list after the merge window, but please
> > do take them for a spin if you get a chance.
> >
> 
> Forgot to reply here. Took them for a spin last week with that commit.
> No more boot hangs but I can't say much else beyond that. When you post
> to the list I'll add my tested-by.

Thanks Stephen. I've also got some patches for OS save/restore of the debug
registers using the various hardware locking and readout mechanisms, so that
debug state can be persisted across low-power states.

Do any of the Qualcomm chips (v7 as opposed to v7.1) implement the save/restore
registers?

Will

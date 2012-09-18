From: viric@viric.name (=?iso-8859-1?Q?Llu=EDs?= Batlle i Rossell)
Date: Tue, 18 Sep 2012 17:46:27 +0200
Subject: Bad traps for unaligned access in STM instruction
In-Reply-To: <alpine.LFD.2.02.1209181140450.28681@xanadu.home>
References: <20120915104602.GY1943@vicerveza.homeunix.net>
 <20120915105151.GZ1943@vicerveza.homeunix.net>
 <20120918152502.GB2110@linaro.org>
 <20120918153119.GC8632@vicerveza.homeunix.net>
 <alpine.LFD.2.02.1209181140450.28681@xanadu.home>
Message-ID: <20120918154627.GD8632@vicerveza.homeunix.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 11:44:02AM -0400, Nicolas Pitre wrote:
> On Tue, 18 Sep 2012, Llu?s Batlle i Rossell wrote:
> 
> > In an ideal userland software world, the counters of the traps would be zero.
> > But they are not. And without fixup, the mkfs.btrfs fails to run properly, and
> > creates a broken filesystem that crashes the kernel.
> 
> If a broken btrfs filesystem crashes the kernel, you should definitively 
> report it as a bug to the btrfs developers.  Filesystem code must be 
> immune to any kind of corruptions and gracefully cope with them.

Yes I know; I did report that.

Thank you

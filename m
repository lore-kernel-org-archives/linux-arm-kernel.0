From: will.deacon@arm.com (Will Deacon)
Date: Tue, 27 May 2014 19:49:40 +0100
Subject: [for-next][PATCH] ftrace: Make CALLER_ADDRx macros more generic
In-Reply-To: <20140527091019.54a8d2d6@gandalf.local.home>
References: <1394705630-12384-1-git-send-email-takahiro.akashi@linaro.org>
 <1394862353-28963-7-git-send-email-takahiro.akashi@linaro.org>
 <20140416135217.GF1001@arm.com> <535E3040.7090402@linaro.org>
 <20140527091019.54a8d2d6@gandalf.local.home>
Message-ID: <20140527184940.GA26035@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 02:10:19PM +0100, Steven Rostedt wrote:
> Will,
> 
> I made a separate branch called ftrace/arm64 as shown below. You can
> pull that branch to base the rest of Akashi-san's patches on top of it.
> The branch is based on top of v3.15-rc5.

Thanks Steve, I'll pull that in.

Akashi: please can you re-send your series, based on the branch below and
including the acks/reviewed-by tags you got for v6 of the patches?

Cheers,

Will

>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> ftrace/arm64
> 
> Head SHA1: eed542d6962ba33a689b4007a389f466e407bd74

From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 12 May 2014 12:05:35 -0400
Subject: [PATCH v8 1/8] ftrace: make CALLER_ADDRx macros more generic
In-Reply-To: <20140512155811.GB4880@arm.com>
References: <1394862048-28758-1-git-send-email-takahiro.akashi@linaro.org>
 <1398851676-16389-1-git-send-email-takahiro.akashi@linaro.org>
 <1398851676-16389-2-git-send-email-takahiro.akashi@linaro.org>
 <20140502151957.6978d870@gandalf.local.home>
 <20140512155811.GB4880@arm.com>
Message-ID: <20140512120535.041030dd@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 May 2014 16:58:11 +0100
Will Deacon <will.deacon@arm.com> wrote:

> Akashi: did you get around to posting a new version of this patch? We can't
> take your arm64 patches until you get the core stuff merged...

I haven't seen any patches yet.

What I can also do is to create a separate branch based on mainline,
and just apply this change to the core. Then you could pull that branch
with a note to Linus that it is also in my tree with the common
ancestor.

If he pulls your work first, he'll only get that change from my tree,
and if he pulls mine first it doesn't matter as all the changes will be
there.

This is something he said at Kernel Summit that was normal procedure if
there's a change in one tree that another tree is dependent on.

-- Steve

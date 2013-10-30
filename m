From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Oct 2013 14:30:23 +0100
Subject: [PATCH 4/4] ARM: msm: Remove 8x50 support
In-Reply-To: <20131029211901.GB16284@fifo99.com>
References: <1382993006-27359-1-git-send-email-davidb@codeaurora.org>
 <1382993006-27359-5-git-send-email-davidb@codeaurora.org>
 <20131029211901.GB16284@fifo99.com>
Message-ID: <201310301430.24115.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 October 2013, Daniel Walker wrote:
> Isn't this the Nexus one platform ? Same as the last one , why don't you
> just update it to use the device tree? This doesn't seem like it would
> be all that difficult. 

Please don't top-post.

> On Mon, Oct 28, 2013 at 01:43:26PM -0700, David Brown wrote:
> > 
> > This code has not been converted to device tree, and is hindering
> > support for the multi-platform kernel on ARM.  If someone wishes to
> > continue support for this target, patches that provide devicetree and
> > multi-platform support can start by re-adding these files.

    ^ Here is your answer.


While I'd definitely love to see support for the Nexus One upstream,
it is evident that nobody has been working on this for a long time.

	Arnd

From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 18 Jul 2014 23:30:10 -0400
Subject: [PATCH 2/4] ARM: add IPI tracepoints
In-Reply-To: <alpine.LFD.2.11.1407182249020.3647@knanqh.ubzr>
References: <1405660735-13408-1-git-send-email-nicolas.pitre@linaro.org>
 <1405660735-13408-3-git-send-email-nicolas.pitre@linaro.org>
 <20140718160418.54d11f6a@gandalf.local.home>
 <alpine.LFD.2.11.1407181652080.3647@knanqh.ubzr>
 <20140718172221.6dbe83e4@gandalf.local.home>
 <alpine.LFD.2.11.1407182249020.3647@knanqh.ubzr>
Message-ID: <20140718233010.620d7a79@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Jul 2014 22:55:12 -0400 (EDT)
Nicolas Pitre <nicolas.pitre@linaro.org> wrote:

> Any comments / ACKs on the other patches?  I'd like to see 1/4 to 3/4 
> (and your patch) merged upstream during the next window.  4/4 is up for 
> debate.

You can add my Acked-by for patches 1,2 and 3, after the clean up of
the #ifdefs there.

I still don't like the fact that you need to add the #undef in patch 4.
I'm looking at other ways to fix that. I tried to do a few different
clean ups in the tracing infrastructure, but it seems that it may be
required. The other method I may try is to move the #undefs into the
ipi.h header itself.

I'll play more with this on Monday.

-- Steve

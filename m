From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 09 Nov 2009 13:48:10 +0200
Subject: [PATCH v3 1/2] arm: a driver for on-chip ETM and ETB
In-Reply-To: <20091030121024.GB15200@shisha.kicks-ass.net>
References: <1256230315-22340-1-git-send-email-virtuoso@slind.org>
	<20091030121024.GB15200@shisha.kicks-ass.net>
Message-ID: <1257767290.21596.307.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-10-30 at 14:10 +0200, Alexander Shishkin wrote:
> On Thu, Oct 22, 2009 at 07:51:54PM +0300, Alexander Shishkin wrote:
> > Changes:
> > v3 -- major update:
> >       * switched from platform device to AMBA device
> >       * started using clk API in a more proper way
> >       * changed omap3 Kconfig part to select the driver instead of depending
> >         on it
> 
> Russell, I believe this one addresses your concerns about my previous patches.
> Shall I wait for more comments from you or do you want me to upload them to
> your patch tracker?

Alex, I suggest you to:

1. Double check that you really addressed _everything_ Russel and others
pointed - may be this is the reason why your patch is stuck.

2. If you have addressed everything, upload the patch to the patch
system. My (very limited) experience was that I re-sent a patch several
times, got no response for long time, but then Russel simply asked me to
upload it, and it was merged. Thus, the silence may simply mean "upload
to the patch system".

HTH.

-- 
Best Regards,
Artem Bityutskiy (????? ????????)

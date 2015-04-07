From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 7 Apr 2015 14:49:11 +0200
Subject: irqchip heirarchy DT "break" series awareness?
In-Reply-To: <20150407124016.GD7873@io.lakedaemon.net>
References: <20150406144647.GC7873@io.lakedaemon.net>
 <20150407115922.5d4c6233@free-electrons.com>
 <20150407124016.GD7873@io.lakedaemon.net>
Message-ID: <20150407144911.1736c162@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

On Tue, 7 Apr 2015 12:40:16 +0000, Jason Cooper wrote:

> Because my goal here was to give *every* possible chance for an
> objection.  Hence, "dt" and "break" in the subject line, sent to the
> devicetree ML.  Also, Marc mentioned the possibility in at least the
> cover letter of each of his series.  I don't want anything hidden.
> 
> But you are absolutely correct.  (2) was never guaranteed, and it's also
> highly improbable as well.  See below.

Right.


> > However, my slides are definitely not about #2 (which as said earlier,
> > was never planned to be something we should worry about), but really
> > about #1.
> 
> I was referring to the slide where you mention that distros and vendors
> have tied the dtbs to the kernel versions (Slide 23/27, "Usefulness").
> I should have been more specific when taking something out of context.
> :-P
> 
> My point, not well made, was that everyone has decided to slave the
> upgrade of the dtb to the upgrade of the kernel.  There is no 'apt-get
> armv7-dtbs' that has no dependency structure on a kernel package.  So we
> agree, (2) was never guaranteed, and isn't probable either.

And so is (1), then :-)

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

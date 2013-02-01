From: tony@atomide.com (Tony Lindgren)
Date: Fri, 1 Feb 2013 10:26:37 -0800
Subject: [PATCH 1/1] ARM: OMAP3: igep0020: simplify GPIO LEDs dependencies
In-Reply-To: <CABxcv=k6wypYO+JOV1rWyuGtR-seNQ2PFqym7QsAdkC+mC7P8g@mail.gmail.com>
References: <1355505428-24302-1-git-send-email-javier.martinez@collabora.co.uk>
 <CABxcv=k6wypYO+JOV1rWyuGtR-seNQ2PFqym7QsAdkC+mC7P8g@mail.gmail.com>
Message-ID: <20130201182637.GJ22517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Javier Martinez Canillas <javier@dowhile0.org> [121220 06:08]:
> 
> Any comments on this patch?

No comments, sorry for the delay. Applying it into omap-for-v3.9/board.
 
> I wonder if I should keep sending fixes/improvements for board-igep0020.c
> 
> I already sent an initial Device Tree support for IGEP boards [1] and
> Benoit told me he is going to queue for 3.9. But still doesn't support
> many peripherals found on these boards because they still don't proper
> DT support, for instance NAND and Ethernet need the GPMC bindings
> patches that haven't hit mainline yet.
> 
> So, it seems I will have to keep working on the board file until it
> can be completely deprecated.

Yes we still have few missing things for complete DT support. While we
are working at it, let's just keep the board-*.c changes to minimum.

Regards,

Tony
 
> Thanks a lot and best regards,
> Javier
> 
> [1]: http://www.mail-archive.com/linux-omap at vger.kernel.org/msg82383.html

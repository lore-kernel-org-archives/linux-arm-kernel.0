From: martinez.javier@gmail.com (Javier Martinez Canillas)
Date: Mon, 25 Jun 2012 10:09:28 +0200
Subject: [PATCH 1/1 v2] ARM: only call smp_send_stop() on SMP
In-Reply-To: <20120625005134.GA2342@S2101-09.ap.freescale.net>
References: <1340533690-4049-1-git-send-email-javier@dowhile0.org>
 <20120625005134.GA2342@S2101-09.ap.freescale.net>
Message-ID: <CAAwP0s2WOxT5YM0zbJrBvsoUh2n6wGuahM7ahY5jGOBJkGEJig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2012 at 2:51 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> It seems the same patch has been there for a while.
>
> http://thread.gmane.org/gmane.linux.kernel/1303115
>
> Regards,
> Shawn
>

Hi Shawn,

Thanks for the info, I first send this patch:
http://www.spinics.net/lists/linux-omap/msg72489.html but Russell
pointed me to the thread:
http://lists.arm.linux.org.uk/lurker/thread/20120523.200015.2fdfd505.en.html
and told me that no patch ever came from his response on the subject.
That's why I sent this patch with Russell suggested approach to solve
the issue. But as you said, it was sent but got lost.

That's a pity since the bug is pretty serious (it deterministically
crashes when trying to reboot the board).

Thanks a lot and best regards,
Javier

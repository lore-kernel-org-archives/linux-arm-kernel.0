From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 20 Mar 2010 13:09:39 +0100
Subject: [PATCH 1/3] watchdog: Add support for the Freescale MXC watchdog
In-Reply-To: <1269011607-23077-1-git-send-email-vzapolskiy@gmail.com>
References: <1269011607-23077-1-git-send-email-vzapolskiy@gmail.com>
Message-ID: <20100320120939.GA5515@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 19, 2010 at 06:13:27PM +0300, Vladimir Zapolskiy wrote:
> Add driver for the Freescale MXC SoCs built-in watchdog.

Any improvements over/differences to this one?

http://article.gmane.org/gmane.linux.ports.arm.kernel/70753

(Read the thread for the comments I received)

Coincidence, I wanted to pick up my version and finish it next week. We have to
agree how to continue. I like mine a tad better (there are some mixups of
MX1/2+ capabilities in yours, e.g. SETTIMEOUT) and it also got review already,
but of course I am biased ;) What do you suggest?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100320/dddf8ec8/attachment.sig>

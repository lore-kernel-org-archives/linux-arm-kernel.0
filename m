From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 19 May 2013 23:40:33 +0200
Subject: [PATCH v2] ARM: sunxi: New watchdog driver for Allwinner A10/A13
In-Reply-To: <F595BD7D-09B6-452A-B8FF-C7B667CE1DF8@gmail.com>
References: <1368903956-32388-1-git-send-email-carlo.caione@gmail.com>
 <20130519153235.GC7717@lukather>
 <F595BD7D-09B6-452A-B8FF-C7B667CE1DF8@gmail.com>
Message-ID: <20130519214033.GA8509@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 19, 2013 at 07:01:54PM +0200, Carlo Caione wrote:
> 
> On May 19, 2013, at 5:32 PM, Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > Hi Carlo,
> 
> Hi Maxime,
> 
> >> +
> >> +#define WDT_CTRL                0x00
> >> +#define WDT_CTRL_RESTART        (1 << 0)
> >> +#define WDT_CTRL_RESERVED       (0x0a57 << 1)
> > 
> > You didn't replied to me on that part in the previous mail. It doesn't
> > seem to be needed, so why keeping it?
> 
> Actually I wrote you about this on irc (probably you were afk)
> Anyway I tested the driver without using the 0x0a57 and without these bits the watchdog is never successfully kicked.
> I'm going to submit a v3 soon, addressing also the suggestions given by Henrik on linux-sunxi ml.

Ok, please discuss this both using mails and by keeping all the
recipients... I wasn't in copy of these mails anymore, neither were the
kernel mailing lists which makes it a pain for the archives and for
other people being part of the discussions.

Please always reply-to-all, and with mails, to these questions.

Anyway, ok. Put a comment explaining why you need it then.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

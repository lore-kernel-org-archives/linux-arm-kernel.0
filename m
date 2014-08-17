From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Sun, 17 Aug 2014 22:35:12 +0200
Subject: [PATCH v7] 8250-core based serial driver for OMAP + DMA
In-Reply-To: <20140815202826.GC9239@atomide.com>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>
 <20140815181704.GH17769@csclub.uwaterloo.ca>
 <53EE5BF8.3010007@linutronix.de>
 <20140815202826.GC9239@atomide.com>
Message-ID: <20140817203512.GA24330@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren | 2014-08-15 13:28:27 [-0700]:

>> It configured the trigger levels to 1 for RX and 16 for TX.
>
>Hmm that weird RX trigger level is a workaround for lost characters.
>
>See commit 0ba5f66836 (tty: serial: OMAP: use a 1-byte RX FIFO
>threshold in PIO mode :)
>
>There's paste test in that commit, I wonder if the 8250 drivers
>can deal with it any better?

I recall that I used it as a console and didn't see any missing chars.
I will try test but I am traveling this week?

>Regards,
>
>Tony

Sebastian

From: tony@atomide.com (Tony Lindgren)
Date: Mon, 10 Sep 2012 11:55:35 -0700
Subject: [PATCH] ARM: OMAP4: wakeupgen: remove duplicate AUXCOREBOOT*
 read/write
In-Reply-To: <CAMQu2gw-KPQzYKtjJUxZjEX+_HKLL9WTxXXA35_ki8KbN+WDYg@mail.gmail.com>
References: <alpine.DEB.2.00.1209052333410.11516@utopia.booyaka.com>
 <CAMQu2gzCz+bS7U1ypFWzcp3zTpkfHdPzZfFtJ8Cd4ap8FSzJQg@mail.gmail.com>
 <CAMQu2gw-KPQzYKtjJUxZjEX+_HKLL9WTxXXA35_ki8KbN+WDYg@mail.gmail.com>
Message-ID: <20120910185535.GC1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [120908 01:20]:
> 
> Will you able to pick up these couple of wakeupgen fixes from  here or
> do you want me to send you a pull request for 3.6-rc5/6

I can pick them into fixes-noncritical. But if the second one is
a major bug for the -rc series, the patch should be describe what
breaks (regression? oops?).

Regards,

Tony

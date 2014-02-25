From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Feb 2014 20:11:01 +0100
Subject: [PATCH resend] pwm: Remove obsolete HAVE_PWM Kconfig symbol
In-Reply-To: <20140210102017.GA20143@ulmo.nvidia.com>
References: <1390550056-5924-1-git-send-email-s.hauer@pengutronix.de>
 <20140210102017.GA20143@ulmo.nvidia.com>
Message-ID: <201402252011.01902.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 February 2014, Thierry Reding wrote:
> On Fri, Jan 24, 2014 at 08:54:16AM +0100, Sascha Hauer wrote:

> > Thierry as PWM maintainer has agreed to take this patch. Would be nice
> > to get some Acks from affected architectures. Russell, Ralf?
> 
> No replies for over two weeks and this looks simple enough, so I just
> went ahead and applied it. Thanks,

Am I looking in the wrong place, or have you not pushed this for linux-next yet?
I still see all the HAVE_PWM symbols in today's -next.

	Arnd

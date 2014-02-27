From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 27 Feb 2014 13:09:33 +0100
Subject: [PATCH resend] pwm: Remove obsolete HAVE_PWM Kconfig symbol
In-Reply-To: <201402252011.01902.arnd@arndb.de>
References: <1390550056-5924-1-git-send-email-s.hauer@pengutronix.de>
 <20140210102017.GA20143@ulmo.nvidia.com>
 <201402252011.01902.arnd@arndb.de>
Message-ID: <20140227120932.GA21422@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 08:11:01PM +0100, Arnd Bergmann wrote:
> On Monday 10 February 2014, Thierry Reding wrote:
> > On Fri, Jan 24, 2014 at 08:54:16AM +0100, Sascha Hauer wrote:
> 
> > > Thierry as PWM maintainer has agreed to take this patch. Would be nice
> > > to get some Acks from affected architectures. Russell, Ralf?
> > 
> > No replies for over two weeks and this looks simple enough, so I just
> > went ahead and applied it. Thanks,
> 
> Am I looking in the wrong place, or have you not pushed this for linux-next yet?
> I still see all the HAVE_PWM symbols in today's -next.

I had pushed to the wrong tree. It should be in linux-next as of today.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140227/7266df5f/attachment-0001.sig>

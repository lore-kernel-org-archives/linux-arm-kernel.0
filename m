From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 20 Mar 2013 07:40:00 -0700
Subject: [PATCH v6 00/16] clk: exynos4/5: migrate to common clock
 framework
In-Reply-To: <11af01ce2526$63b0a8f0$2b11fad0$%kim@samsung.com>
References: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
 <20130319184938.8663.18115@quantum> <201303192212.16877.heiko@sntech.de>
 <20130319215038.8663.83548@quantum>
 <116a01ce24fd$e32658b0$a9730a10$%kim@samsung.com>
 <20130320025656.11073.90469@quantum>
 <11af01ce2526$63b0a8f0$2b11fad0$%kim@samsung.com>
Message-ID: <20130320144000.11073.37741@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Kukjin Kim (2013-03-19 21:50:05)
> Mike Turquette wrote:
> > 
> > Quoting Kukjin Kim (2013-03-19 17:00:09)
> > > Mike Turquette wrote:
> > > >
> > >
> > > [...]
> > >
> > > > > > Thomas,
> > > > > >
> > > > > > Are you planning a V7 series which includes the clock alias bits from
> > > > > > patch #1?
> > > > >
> > > > > Kukjin has already applied this series into the linux-samsung tree [0].
> > > > >
> > > Thanks, Heiko.
> > >
> > > Mike, yes I did, as we discussed before. Since I missed in last window for
> > v3.9, so I merged every common clock stuff for exynos into samsung tree in the
> > early 3.9-rc time for v3.10.
> > > >
> > > > That really is too much code to go into drivers/clk without my ACK.  I
> > > > have not made much noise about this in the past but there has been more
> > > > and more "bonus" code slipping into drivers/clk each merge window.
> > > > Let's not do that any more.
> > > >
> > >
> > > Hmm, I remember you already agreed on previous version, and I thought if any
> > further codes are required, we could do it on top of that.
> > > http://lists.infradead.org/pipermail/linux-arm-kernel/2013-
> > January/143429.html
> > >
> > 
> > In the email you linked to my use of the word "merged" did not imply an
> > ACK.  I was asking about merging the two separate exynos4 and exynos5
> > ccf development efforts together.
> > 
> OK, I see.
> 
> > Furthermore if I *had* agreed on the previous version it would still
> > have been appropriate to put my Acked-by on those patches, which is
> > clearly missing today.
> > 
> BTW, how about following?
> 
> http://www.spinics.net/lists/arm-kernel/msg210266.html
> 
> In my understanding, it should be your agreement, it cannot be 'ack' though.
> 

I had forgotten about that email from November.  Still my ack should
have been added.  If necessary I'll be painfully explicit in the future
about adding my acked-by.  It's a simple and good rule to follow.

Thanks,
Mike

> > > However, if you don't want current codes to be sent to upstream, let me know,
> > but I don't think it would be better to us though.
> > 
> > No, I am not asking you to revert/drop the patches, but I am using this
> > as a public example.
> > 
> What's the 'public example'?
> 
> As I linked, you already said 'sounds good to me' on my asking.
> 
> - Kukjin

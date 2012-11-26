From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Mon, 26 Nov 2012 01:32:40 -0800
Subject: [PATCH 1/2] input: gpio-keys: Disable hardware on suspend
In-Reply-To: <20121126090503.GB12782@gmail.com>
References: <1353590617-11466-1-git-send-email-lee.jones@linaro.org>
 <20121125083229.GB21091@core.coreip.homeip.net>
 <20121126090503.GB12782@gmail.com>
Message-ID: <20121126093240.GB13792@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 09:05:03AM +0000, Lee Jones wrote:
> > On Thu, Nov 22, 2012 at 01:23:36PM +0000, Lee Jones wrote:
> > > From: Jonas Aaberg <jonas.aberg@stericsson.com>
> > > 
> > > Disable hardware if active when suspending if the hw can not
> > > wake the system from suspend.
> > 
> > How about below instead (needs the other patch I have just sent out)?
> 
> Sorry Dmitry, I'm a little confused. What does this mean?

The modified version of the patch I have sent depends on the other patch
to gpio-keys that introduces gpio_keys_report_state() that I believe you
have been CCed.

Thanks.

-- 
Dmitry

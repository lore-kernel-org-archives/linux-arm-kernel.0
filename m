From: mamlinav@gmail.com (Aleksei Mamlin)
Date: Tue, 29 Dec 2015 16:58:19 +0300
Subject: [PATCH] ARM: dts: sun4i: Use red1 LED for heartbeat indication
 on Marsboard A10
In-Reply-To: <20151227205151.GK30359@lukather>
References: <1451123879-7212-1-git-send-email-mamlinav@gmail.com>
 <20151227205151.GK30359@lukather>
Message-ID: <20151229165819.a4c0e978aa5ebd121113cad1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 27 Dec 2015 21:51:51 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> On Sat, Dec 26, 2015 at 12:57:59PM +0300, Aleksei Mamlin wrote:
> > Marsboard A10 have four red LEDs, the first one can be used for
> > heartbeat indication.
> > 
> > Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
> 
> I'm really not sure about this one.
> 
> This is something that can easily be changed through sysfs, and it
> will likely end up being a "war" on what trigger people want to use.
> 

If so, then Ok, please ignore this patch.

Is there any way to set led triggers through cmdline instead of sysfs?

>
> Hans, Chen-Yu, What's your view on this?
> 
> Thanks,
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com


-- 
Thanks and regards,
Aleksei Mamlin

From: kiko@linaro.org (Christian Robottom Reis)
Date: Tue, 3 Jan 2012 11:20:33 -0200
Subject: snowball does not compile on linux-next
In-Reply-To: <CACRpkdZfaOA0suxO8Gp7mw-VGPFju2dCJwDocO_K7Dx4-2z0Rw@mail.gmail.com>
References: <4F0199CF.2070806@linaro.org>
 <CACRpkdbn6H_s8oC3VdqH2CoCZcPkc+hYccLE1UQJZnqB5eSf3Q@mail.gmail.com>
 <20120102152553.GA9771@async.com.br>
 <CACRpkdZfaOA0suxO8Gp7mw-VGPFju2dCJwDocO_K7Dx4-2z0Rw@mail.gmail.com>
Message-ID: <20120103132033.GD9771@async.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2012 at 08:19:37AM +0100, Linus Walleij wrote:
> On Mon, Jan 2, 2012 at 4:25 PM, Christian Robottom Reis <kiko@linaro.org> wrote:
> > On Mon, Jan 02, 2012 at 01:59:10PM +0100, Linus Walleij wrote:
> >> On Mon, Jan 2, 2012 at 12:49 PM, Daniel Lezcano
> >> <daniel.lezcano@linaro.org> wrote:
> >>
> >> > the kernel does not compile when
> >> > CONFIG_CLKSRC_DBX500_PRCMU_SCHED_CLOCK is set.
> >
> > Should this be in our default configs, or one of our tested configs, so
> > we can catch this in a CI loop?
> 
> It should be in the defconfig already, the problem showed up
> for Daniel exactly because it was configured in.

Okay, then the question is what do we need to do to make a box go red
and have people notified when it breaks?
-- 
Christian Robottom Reis, Engineering VP
Brazil (GMT-3) | [+55] 16 9112 6430 | [+1] 612 216 4935
Linaro.org: Open Source Software for ARM SoCs

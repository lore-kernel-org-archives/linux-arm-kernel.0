From: kiko@linaro.org (Christian Robottom Reis)
Date: Mon, 2 Jan 2012 13:25:53 -0200
Subject: snowball does not compile on linux-next
In-Reply-To: <CACRpkdbn6H_s8oC3VdqH2CoCZcPkc+hYccLE1UQJZnqB5eSf3Q@mail.gmail.com>
References: <4F0199CF.2070806@linaro.org>
 <CACRpkdbn6H_s8oC3VdqH2CoCZcPkc+hYccLE1UQJZnqB5eSf3Q@mail.gmail.com>
Message-ID: <20120102152553.GA9771@async.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 02, 2012 at 01:59:10PM +0100, Linus Walleij wrote:
> On Mon, Jan 2, 2012 at 12:49 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> 
> > the kernel does not compile when
> > CONFIG_CLKSRC_DBX500_PRCMU_SCHED_CLOCK is set.

Should this be in our default configs, or one of our tested configs, so
we can catch this in a CI loop?
-- 
Christian Robottom Reis, Engineering VP
Brazil (GMT-3) | [+55] 16 9112 6430 | [+1] 612 216 4935
Linaro.org: Open Source Software for ARM SoCs

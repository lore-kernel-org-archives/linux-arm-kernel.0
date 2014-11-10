From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Nov 2014 15:01:54 +0100
Subject: [GIT PULL] Integrator multiplatform migration for v3.19
In-Reply-To: <20141110135644.GV4042@n2100.arm.linux.org.uk>
References: <CACRpkdafst1j2tp4-=BZMn_P688uUSjeAZEGt26WuD_d521sHQ@mail.gmail.com>
 <20141104063235.GG13562@quad.lixom.net>
 <20141106105246.GO4042@n2100.arm.linux.org.uk>
 <7467543.qEZBkbRV4B@wuerfel>
 <20141110135644.GV4042@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdYht8u5fUc1SYBNJ+yd48p918S-BumTnLOdnMkfSWG+NA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 10, 2014 at 2:56 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> The answer is of course /not/ to remove ARCH_INTEGRATOR but to make
> the processor options depend on !ARCH_MULTIPLATFORM || ARCH_MULTI_xx -
> thus, allowing them to be selected in non-multi-platform environments,
> and also only in their appropriate multi-platform environment.  That
> means we get the best of all worlds.

OK I'll do my best to cook up something like this.

Yours,
Linus Walleij

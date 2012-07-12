From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 12 Jul 2012 17:37:47 +0100
Subject: [PATCH 7/9] Input: ab8500-ponkey: Create AB8500 domain IRQ mapping
In-Reply-To: <CACRpkdYJi3Kk3gpdgFLWr+tun4LZNMw0ET6W2nHJfY5jSvgcjw@mail.gmail.com>
References: <4FF6994B.9040801@linaro.org>
 <20120706173957.GA10202@core.coreip.homeip.net>
 <4FFB288D.4080606@linaro.org>
 <20120709201422.GA12242@core.coreip.homeip.net>
 <4FFB40A4.5060505@linaro.org>
 <20120709204620.GA12692@core.coreip.homeip.net>
 <4FFB463F.9040201@linaro.org>
 <CACRpkdbjkLvD13_g=TvCUYjqhZ7ySOiEL51h9eT3YVMO4Vnr3A@mail.gmail.com>
 <4FFB4B5F.30103@linaro.org>
 <CACRpkdYJi3Kk3gpdgFLWr+tun4LZNMw0ET6W2nHJfY5jSvgcjw@mail.gmail.com>
Message-ID: <20120712163747.GB4488@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2012 at 11:08:39PM +0200, Linus Walleij wrote:
> On Mon, Jul 9, 2012 at 11:21 PM, Lee Jones <lee.jones@linaro.org> wrote:

> > I did test it, but must have only looked at the one IRQ incrementing.

> That's not enough, cat /dev/input/event/* whatever event node is used
> by the ponkey, press it and verify you get some garbage (=events)
> in the console.

There's the evtest debug program which is very handy for testing input
API stuff (Google should throw up copies, it's just a .c file).

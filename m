From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 14 Jul 2012 23:36:10 +0200
Subject: [PATCH 7/9] Input: ab8500-ponkey: Create AB8500 domain IRQ mapping
In-Reply-To: <5000260B.8070907@linaro.org>
References: <1341493572-29735-1-git-send-email-lee.jones@linaro.org>
 <4FF6994B.9040801@linaro.org>
 <20120706173957.GA10202@core.coreip.homeip.net>
 <4FFB288D.4080606@linaro.org>
 <20120709201422.GA12242@core.coreip.homeip.net>
 <4FFB40A4.5060505@linaro.org>
 <20120709204620.GA12692@core.coreip.homeip.net>
 <4FFB463F.9040201@linaro.org>
 <CACRpkdbjkLvD13_g=TvCUYjqhZ7ySOiEL51h9eT3YVMO4Vnr3A@mail.gmail.com>
 <4FFB4B5F.30103@linaro.org>
 <CACRpkdYJi3Kk3gpdgFLWr+tun4LZNMw0ET6W2nHJfY5jSvgcjw@mail.gmail.com>
 <5000260B.8070907@linaro.org>
Message-ID: <CACRpkdbMfC2Yga-8bUFUbMB2vwJuxeqDwDkVjud5ed7+AhOopQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2012 at 3:43 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On 10/07/12 22:08, Linus Walleij wrote:

>> That's not enough, cat /dev/input/event/* whatever event node is used
>> by the ponkey, press it and verify you get some garbage (=events)
>> in the console.
>
> Yes, garbage seen, works fine.

OK!
Acked-by: on whatever Dmitry Acked.

Yours,
Linus Walleij

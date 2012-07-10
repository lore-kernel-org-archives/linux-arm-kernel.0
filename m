From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Jul 2012 23:08:39 +0200
Subject: [PATCH 7/9] Input: ab8500-ponkey: Create AB8500 domain IRQ mapping
In-Reply-To: <4FFB4B5F.30103@linaro.org>
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
Message-ID: <CACRpkdYJi3Kk3gpdgFLWr+tun4LZNMw0ET6W2nHJfY5jSvgcjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 9, 2012 at 11:21 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On 09/07/12 23:03, Linus Walleij wrote:

>> Now since I was fooled by the last patch, thinking you had tested it
>> before
>> submitting (obviously not) - please send a test log of some
>> cat /dev/input/event* for this one before I ACK it this time.

(Hm, sorry for grumpy mode...)

> I did test it, but must have only looked at the one IRQ incrementing.

That's not enough, cat /dev/input/event/* whatever event node is used
by the ponkey, press it and verify you get some garbage (=events)
in the console.

Yours,
Linus Walleij

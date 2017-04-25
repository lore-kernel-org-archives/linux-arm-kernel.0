From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Apr 2017 10:15:04 +0200
Subject: [PATCH 4/5 v3] usb: host: fotg2: add Gemini-specific handling
In-Reply-To: <alpine.LNX.2.00.1704241853240.15211@T420s>
References: <20170421204058.6206-1-linus.walleij@linaro.org>
 <20170421204058.6206-4-linus.walleij@linaro.org>
 <alpine.LNX.2.00.1704241853240.15211@T420s>
Message-ID: <CACRpkdZoQJuyn_0j10Opu9t4ZgTEWenihNstLbYu7jk8d4ugyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 24, 2017 at 7:06 PM, Hans Ulli Kroll
<ulli.kroll@googlemail.com> wrote:

> please wait for a while, I'm working on some glue code to support both
> host and device mode on FOTG.

Sure no problem, sorry for being so impatient, it's a character trait.

I sent out bindings and drivers for the Gemini clock controller and reset
controller, so we might want to queue the clock handling at least.
I'm happy if you pick some of these patches and keep them in your
queue BTW.

Yours,
Linus Walleij

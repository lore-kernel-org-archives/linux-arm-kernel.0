From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Feb 2016 20:32:18 +0100
Subject: [PATCH 11/11] ARM: versatile: move CLCD configuration to device
 tree
In-Reply-To: <56CF2FB1.106@ti.com>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <3695074.sKSIyOjpjD@wuerfel>
 <CACRpkdZjfjOCFUucF1U5yVZBxSwa41GKEMv-HHQE=ymF2NZ21g@mail.gmail.com>
 <6859810.tb1t0IEONi@wuerfel> <56CC57FC.20707@ti.com>
 <CACRpkdYNaNtQQJ-tsBe5ksa4-z380ZQj-zN8ZnK0ED2kNPUwvg@mail.gmail.com>
 <56CC60C4.6040908@ti.com>
 <CACRpkdZd8TLdsi7_cOrqzcqWKJrfdp4Vz2sx5ozpwJXOj0fa+Q@mail.gmail.com>
 <56CF2FB1.106@ti.com>
Message-ID: <CACRpkdZdGzxgZHAHwoSXZUSZGPf4MC+LUN0a97pyDyR4qxsS_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2016 at 5:45 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

> Anyway, if it's likely that we're not seeing new CLCD boards, I think
> it's fine if we don't go to any great lengths to clean things up there.
> Let's just get it working.

Do you think you could merge the other patch set I made, that doesn't
even deal with this plug-n-play-panel issue?

I have rebased the two approaches to autodetection on top of that.

Yours,
Linus Walleij

From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 5 Mar 2016 23:57:38 +0700
Subject: [PATCH 11/11] ARM: versatile: move CLCD configuration to device
 tree
In-Reply-To: <56D02D28.9080109@ti.com>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <3695074.sKSIyOjpjD@wuerfel>
 <CACRpkdZjfjOCFUucF1U5yVZBxSwa41GKEMv-HHQE=ymF2NZ21g@mail.gmail.com>
 <6859810.tb1t0IEONi@wuerfel> <56CC57FC.20707@ti.com>
 <CACRpkdYNaNtQQJ-tsBe5ksa4-z380ZQj-zN8ZnK0ED2kNPUwvg@mail.gmail.com>
 <56CC60C4.6040908@ti.com>
 <CACRpkdZd8TLdsi7_cOrqzcqWKJrfdp4Vz2sx5ozpwJXOj0fa+Q@mail.gmail.com>
 <56CF2FB1.106@ti.com>
 <CACRpkdYowXJinONTd2qREfCtEDCon+HSQtdd6t1QQA91f6PJdw@mail.gmail.com>
 <56D02D28.9080109@ti.com>
Message-ID: <CACRpkdaJ1xzRp4gg1wLSoo_se+LEC9sUDZ-9L2iZ1g4GPj_dZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 5:47 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

> Although one thing to consider is that if there is ever going to be a
> DRM driver for CLCD, it would be good to have the device tree parts
> correctly representing the hardware, so that the DRM driver could be
> implemented in a cleaner, more generic way.

OK so for the next kernel cycle I can work on that.

The non-controversial patch set is essentially just using the DT bindings
that are already in the kernel and in widespread use. See:
commit d10715be03bd8bad59ddc50236cb140c3bd73c7b
"video: ARM CLCD: Add DT support"

They follow the example set by
commit 478a4f81af4936c683a03488e15b087e28cb4f0d
"ARM: vexpress: Add CLCD Device Tree properties"

Yours,
Linus Walleij

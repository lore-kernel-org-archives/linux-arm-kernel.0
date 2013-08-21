From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Aug 2013 00:57:08 +0200
Subject: [PATCH 0/3] ARM: vexpress_defconfig: Allow to boot using a
 regular filesystem on SD card
In-Reply-To: <1377082313.10707.11.camel@hornet>
References: <1377032563-4502-1-git-send-email-fathi.boudra@linaro.org>
 <1377075956.3591.23.camel@linaro1.home>
 <1377082313.10707.11.camel@hornet>
Message-ID: <CACRpkdbruw8J26cva-kgXXZuMM-8z9BFpuaY=_QJqCzYYdVaqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 12:51 PM, Pawel Moll <pawel.moll@arm.com> wrote:

> This gets down to the question do we actually want the
> vexpress_defconfig at all?

I added it because people were complaining that I was not
testing code against Vexpress and there was no way to
conveniently do that without a defconfig.

It is also used in Rothwells kisskb:
http://kisskb.ellerman.id.au/kisskb/branch/9/

Yours,
Linus Walleij

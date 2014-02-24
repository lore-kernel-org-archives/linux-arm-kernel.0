From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Feb 2014 10:37:58 +0100
Subject: [PATCH 0/6] ARM: integrator: multiplatform advancements
In-Reply-To: <20140214134756.GI30257@n2100.arm.linux.org.uk>
References: <1392373771-17303-1-git-send-email-linus.walleij@linaro.org>
 <20140214134756.GI30257@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdYfbgi_PY_OJpifzaS9x1fgLhGir05VS7BAw4QT5ZGMmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 2:47 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Feb 14, 2014 at 11:29:25AM +0100, Linus Walleij wrote:
>> The *real* solution, one might argue is to convert the CLCD
>> driver to DRM and add device tree bindings, but it appears that
>> this is an orthogonal goal that has been attempted by other with
>> mixed results.
>
> What mixed results?  You know, I find it rather sick that people run
> around trying to do this to a driver that I authored and maintain
> without one comment to me about it.  It sometimes feels like people
> think I don't exist anymore.

Sorry, I was referring to this driver for PL111:
http://marc.info/?l=linux-arm-kernel&m=137477285809710&w=2

So I take it that the PL111 is a totally different beast from
PL110 except for the single digit difference in the name.
Whereas PL180 and PL181 are essentially the same piece
of hardware...

Then there is this patch set for DT support for the CLCD which
appears to be orthogonal:
http://marc.info/?l=linux-arm-kernel&m=137968689722364&w=2

Pawel, is this coming along?

Yours,
Linus Walleij

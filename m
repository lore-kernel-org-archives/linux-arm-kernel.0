From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 11 May 2012 16:24:11 -0600
Subject: [PATCH 4/7] drivers/gpio: gpio-nomadik: Provide documentation for
 Device Tree bindings
In-Reply-To: <CACRpkdZDQ=Sx2_X=j4+ka59HU3Q2s+KnY1UAaGaU-u82JWd0bQ@mail.gmail.com>
References: <1333619748-16126-1-git-send-email-lee.jones@linaro.org>
 <1333619748-16126-5-git-send-email-lee.jones@linaro.org>
 <20120406042054.C0C433E0C86@localhost>
 <4F83E041.7040108@linaro.org> <20120511191205.9BD0E3E0791@localhost>
 <CACRpkdZDQ=Sx2_X=j4+ka59HU3Q2s+KnY1UAaGaU-u82JWd0bQ@mail.gmail.com>
Message-ID: <CACxGe6tm_5bdk+p84mAfy6MhJZdP3VUrMkcO3Sg+Ci2Qznd0FA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 4:18 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, May 11, 2012 at 9:12 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
>
>> Are the banks all part of a single GPIO device?
>
> No. The banks are individual pieces of silicon instance, so they
> each have separate reset and clock lines for example.
>
> Apart from that I just vaguely grasp what you're discussing here :-)

Don't worry about it. After reading further, it looks okay.

g.

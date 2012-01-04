From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 5 Jan 2012 00:44:45 +0100
Subject: [PATCH] clps711x: fix compilation breakage
In-Reply-To: <20120104211314.GD11810@n2100.arm.linux.org.uk>
References: <1325673453-22278-1-git-send-email-linus.walleij@linaro.org>
 <20120104211314.GD11810@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdbGb+9LQLySZv6fjKSY0ZE-KkTPsD3VoG+fEW8D-=RJow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 4, 2012 at 10:13 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jan 04, 2012 at 11:37:33AM +0100, Linus Walleij wrote:
>> The restart patches defined a new restart function in common.c
>> but it needs to be declared in common.h to compile properly.
>
> Hmm, this ought to be merged into the commit which created the breakage -
> are you ok if I just fix that commit?

Of course, go ahead.

Thanks Russell,
Linus Walleij

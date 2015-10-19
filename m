From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 19 Oct 2015 23:50:11 +0200
Subject: [PATCH] ARM64: juno: add NOR flash to device tree
In-Reply-To: <20151019112749.GB10728@bivouac.eciton.net>
References: <1444904415-19597-1-git-send-email-linus.walleij@linaro.org>
 <561FC681.2040809@arm.com>
 <CACRpkdaSox9WKb5-dkD_zAwO9WxP6+b010p3bdxsm1LRy=WvKg@mail.gmail.com>
 <5624C31D.3070906@arm.com> <20151019102932.GB10678@leverpostej>
 <CACRpkdaGscb_ccbGuwccsRj_b1d6xoveiiZpw1a5eXon3PxAUA@mail.gmail.com>
 <20151019112749.GB10728@bivouac.eciton.net>
Message-ID: <CACRpkdakQdCpbFzxb0AkHBStSWNWzTub8A72=5YPkbHTjnor0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 1:27 PM, Leif Lindholm <leif.lindholm@linaro.org> wrote:

> This would be true for any preceding ARM devboard, but Juno's boot
> architecture is different. The thing that gives the 'Cmd>' prompt is
> running on a system microcontroller. It writes images to the system
> NOR based on the contents of images.txt in the magic USB filesystem.

Yeah OK I stand corrected ... I just called that thing boot monitor
because I never saw a real name for it. It's something system-resident
that is not the boot loader anyways, and it doesn't seem designed
with any one particular boot architecture in mind.

Yours,
Linus Walleij

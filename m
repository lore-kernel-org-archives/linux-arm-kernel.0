From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 16 Jun 2015 09:03:36 +0200
Subject: [PATCH 0/5] EP93xx GENERIC_CLOCKEVENTS
In-Reply-To: <DC148C5AA1CEBA4E87973D432B1C2D883D49CA16@P3PWEX4MB008.ex4.secureserver.net>
References: <1434376222-4587-1-git-send-email-linus.walleij@linaro.org>
 <DC148C5AA1CEBA4E87973D432B1C2D883D49CA16@P3PWEX4MB008.ex4.secureserver.net>
Message-ID: <CACRpkdbwpfHeiESZ9c71m5GV7VMGO3e0ky13mdEZMQ=8vpM0BQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 15, 2015 at 7:25 PM, Hartley Sweeten
<HartleyS@visionengravers.com> wrote:

> Tested on Vision Engraving Systems EP9307 (vision_ep9307.c).
>
> You can use whatever tag is appropriate:
>
> Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Awesome.

Do you want to queue this material for v4.3, or shall I create a branch
to funnel this to ARM SoC? I will put your PATCH_PHYS_TO_VIRT
patch on top of that pile of course.

> One nit...
>
> Is the "Timer handling for EP93xx" comment still correct?
>
> It still mentions a 16-bit timer (timer 1) used for the timer interrupt and gettimeoffset()
> being used with timer 4.

Darn, sent a separate patch to address this.

Yours,
Linus Walleij

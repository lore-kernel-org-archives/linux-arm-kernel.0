From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 28 Apr 2011 09:10:36 +0200
Subject: [PATCH 02/10] mach-u300: rewrite gpio driver, move to drivers/gpio
In-Reply-To: <BANLkTikc7B5J0Z_aiS5kXCxMSxcFrfSRxw@mail.gmail.com>
References: <1303910002-3333-1-git-send-email-linus.walleij@stericsson.com>
	<0D753D10438DA54287A00B027084269764D2650215@AUSP01VMBX24.collaborationhost.net>
	<BANLkTikc7B5J0Z_aiS5kXCxMSxcFrfSRxw@mail.gmail.com>
Message-ID: <BANLkTimG+DQ3yE6hMiTSHGC6VFQ6Nkq4oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/28 Linus Walleij <linus.walleij@linaro.org>:
> 2011/4/27 H Hartley Sweeten <hartleys@visionengravers.com>:
>> # NOTE: platform-specific GPIO drivers don't belong in the
>> # drivers/gpio directory; put them with other platform setup
>> # code, IRQ controllers, board init, etc.
>
> Yeah, you're right. I can take these comments out, simply.
> I'll review the files as bit to make sure there aren't any more
> statements like that.

Thinking of this, the pl061.c driver is already no expansion
chip (it's SoC silicon) so this statement has been wrong for
some time already.

Linus Walleij

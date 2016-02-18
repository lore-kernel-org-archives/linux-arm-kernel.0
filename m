From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 18 Feb 2016 19:55:17 +0100
Subject: Bunch of machines are not booting in next again, GPIO regression?
In-Reply-To: <20160217224415.GA3866@jcartwri.amer.corp.natinst.com>
References: <20160217192755.GC21202@atomide.com>
 <20160217195543.GA871@jcartwri.amer.corp.natinst.com>
 <20160217201259.GA16028@deathstar>
 <20160217202224.GD21202@atomide.com>
 <20160217224415.GA3866@jcartwri.amer.corp.natinst.com>
Message-ID: <CACRpkdY2=mYVDU2BXzN1rY7=mP_iyG3UEaCNVom4HFJDf61+0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 11:44 PM, Josh Cartwright <joshc@ni.com> wrote:

> Here's a properly cooked patch.  Otherwise, feel free to squash it in if
> it's easier for you.
>
> -- 8< --
> Subject: [PATCH] gpio: use kzalloc to allocate gpio_device

Patch applied, of course.

Big hugs and thanks for fixing my stupid mistake!

N?ras,
Linus Walleij

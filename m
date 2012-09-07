From: spartacus06@gmail.com (Seth Jennings)
Date: Thu, 6 Sep 2012 19:56:45 -0500
Subject: [PATCH] ARM: add support for BCM2708/BCM2835 and Raspberry Pi
In-Reply-To: <50491F65.2020302@simon.arlott.org.uk>
References: <1346908038-22421-1-git-send-email-swarren@wwwdotorg.org>
 <CAG-w=x77y6ykh3FcyTtVAN85eOk1RP2CZ=ZG-_1091i5jYDF2A@mail.gmail.com>
 <50491F65.2020302@simon.arlott.org.uk>
Message-ID: <CAG-w=x5dbjk+9E0nWWDd9n-=bhMshMtkCnbLjzP0zufezqFgqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 6, 2012 at 5:10 PM, Simon Arlott <simon@fire.lp0.eu> wrote:
> It has supported graphics for a while:
> https://github.com/raspberrypi/linux/wiki/How-to-boot-using-device-tree#wiki-Configuration

Ah yes, you are correct sir.

> I've been waiting over 3 months now for device tree support to be added
> to the GPU-based bootloader and it still hasn't appeared.

Are the attributes that are currently set by fdtput'ing on the dtb the
ones you want to get from the bootloader?  Or are there others?

I guess another way to say it is I'm interested in getting as much of
this code as we can into mainline as we can before it bitrots (which
can happen fast in on the ARM side I think).  We can make changes as
the proprietary bits catch up.

--
Seth

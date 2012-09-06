From: spartacus06@gmail.com (Seth Jennings)
Date: Thu, 6 Sep 2012 11:53:26 -0500
Subject: [PATCH] ARM: add support for BCM2708/BCM2835 and Raspberry Pi
In-Reply-To: <1346908038-22421-1-git-send-email-swarren@wwwdotorg.org>
References: <1346908038-22421-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CAG-w=x77y6ykh3FcyTtVAN85eOk1RP2CZ=ZG-_1091i5jYDF2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(sorry for the dup Stephen, forgot to reply all :-/)

On Thu, Sep 6, 2012 at 12:07 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>
> The BCM2708 is an ARM SoC from Broadcom. It is the primary SoC in a
> series which contains the BCM2835 amongst other variants. This patch
> adds very basic support for this series of SoCs, under the BCM2708 name.

Great work! I'm glad to see this heading upstream :)

> This series was extracted from git://github.com/lp0/linux.git branch
> rpi-next or rpi-linear from 3-4 months ago, and significantly stripped
> down and modified since.

I've used Simon's tree before and it will boot up all the way with UART
support (no graphics, usb, network).  I also think it has a fully
populated device
tree.  Why, in particular, did you strip it down?

I'm new to the ARM SoC upstreaming scene so there might be a obvious
reason of which I'm not aware.

--
Seth

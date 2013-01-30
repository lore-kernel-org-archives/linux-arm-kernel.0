From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 30 Jan 2013 10:45:42 +0100
Subject: [PATCH] ARM: ux500: rename ab8500 to abx500 for hwmon driver
In-Reply-To: <1359531747-3636-1-git-send-email-hongbo.zhang@linaro.org>
References: <1359531747-3636-1-git-send-email-hongbo.zhang@linaro.org>
Message-ID: <CACRpkdajhr__+8=6JbQAgYBq39S8XJZe6PDjVFA+znOJGHa7uQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 8:42 AM, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:

> We are using a generic abx500 hwmon layer, so rename specific ab8500 to generic
> abx500 for hwmon device and driver matching.
>
> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>

You need to have the ACK:ed by the MFD subsystem maintainer
so that G?nther can merge it later, along with the HWMON patch.

Also combine them into a series, this one as 1/2 and the other
patch as 2/2.

And remember to send both to the relevant maintainers
(see MAINTAINERS file):

HARDWARE MONITORING
M:      Jean Delvare <khali@linux-fr.org>
M:      Guenter Roeck <linux@roeck-us.net>

MULTIFUNCTION DEVICES (MFD)
M:      Samuel Ortiz <sameo@linux.intel.com>

Both patches should also go into the linux-kernel at vger.kernel.org mailing
list "LKML".

Thanks!
Linus Walleij

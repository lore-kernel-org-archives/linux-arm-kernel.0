From: gnurou@gmail.com (Alexandre Courbot)
Date: Wed, 2 Apr 2014 18:36:06 +0900
Subject: [PATCHv3 0/5] net: rfkill: gpio: cleanup and a few new acpi ids
In-Reply-To: <1396360976-28657-1-git-send-email-heikki.krogerus@linux.intel.com>
References: <1396360976-28657-1-git-send-email-heikki.krogerus@linux.intel.com>
Message-ID: <CAAVeFuLXQ99gMW6Kmr4fj2FhccsKUEajBWLn8v33LB_LbGjgqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Negative number of added lines, temporary string buffers removal, and
use of the gpiod interface: lots of stuff to like here!

Acked-by: Alexandre Courbot <acourbot@nvidia.com>

On Tue, Apr 1, 2014 at 11:02 PM, Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
> Hi,
>
> I hope this one is OK with everyone.
>
> Changes since v2:
> - Instead of changing the driver to use only indexed gpios, just
>   hard-coding the names.
>
> Changes since v1:
> - Removed the gpio entries from arch/arm/mach-tegra/board-paz00.c
>
>
> Heikki Krogerus (5):
>   ARM: tegra: remove obsolete gpio entries
>   net: rfkill: gpio: remove unused and obsolete platform parameters
>   net: rfkill: gpio: add ACPI ID for GPS module on Lenovo Miix2
>   net: rfkill: gpio: add ACPI IDs for a Broadcom bluetooth chip
>   net: rfkill: gpio: hard-code the gpio names
>
>  arch/arm/mach-tegra/board-paz00.c |  4 +---
>  include/linux/rfkill-gpio.h       | 10 ----------
>  net/rfkill/rfkill-gpio.c          | 40 +++++++++------------------------------
>  3 files changed, 10 insertions(+), 44 deletions(-)
>
> --
> 1.9.1
>

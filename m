From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 13 Jun 2016 11:23:20 +0800
Subject: [PATCH] ARM: dts: sun8i: Add dts file for Polaroid MID2407PXE03
 tablet
In-Reply-To: <1465653230-1027-1-git-send-email-hdegoede@redhat.com>
References: <1465653230-1027-1-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v649R2VhH6U4YpiFpQp4S_b7N0RCERWjfthdKC_k3FjA3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jun 11, 2016 at 9:53 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> The Polaroid MID2407PXE03 is an a23 based 7" tablet based on a M86_MB V2.0
> PCB, featuring a 800x480 LCD, 512MB RAM, 4G NAND, esp8089 wifi, gsl1680
> touchschreen, micro-sd slot, 3.5mm headphone jack and a micro-usb otg
> connector which doubles as charging port.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

It seems this tablet is very similar to the Q8s, differing only in the
WiFi solution (which we have to deal with for the Q8s anyway), and the
touchscreen firmware.

Should we somehow manage this using the q8-common and q8-tablet dts files?

Same comment for reg_drivevbus as the other patches.

Regards
ChenYu

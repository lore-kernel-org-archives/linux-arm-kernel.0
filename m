From: ahaslam@baylibre.com (Axel Haslam)
Date: Tue, 22 Nov 2016 16:41:30 +0100
Subject: [RESEND PATCH 2/3] ARM: davinci: hawk: Remove vbus and over
 current gpios
In-Reply-To: <cf13650b-1880-7dda-e249-9763bfe3032a@ti.com>
References: <20161121165349.29128-1-ahaslam@baylibre.com>
 <20161121165349.29128-3-ahaslam@baylibre.com>
 <cf13650b-1880-7dda-e249-9763bfe3032a@ti.com>
Message-ID: <CAKXjFTMLt0j4yfHUww6k6FMu4=Z+mhZJCKi-tqmqdaOUs0fJ9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar

On Tue, Nov 22, 2016 at 11:37 AM, Sekhar Nori <nsekhar@ti.com> wrote:
> On Monday 21 November 2016 10:23 PM, Axel Haslam wrote:
>> The hawk board VBUS is fixed to a 5v source, and the over
>> current pin is actually not connected to the SoC.
>>
>> Do not reseve these gpios for OHCI as they are not related
>> to usb.
>>
>> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
>
> As discussed over the MMC/SD patches, this patch should be based off the
> hawkboard schematic, not the LCDK schematic.
>

I looked at the hawkboard schematics and they are the same
as the lcdk as far as usb i concerned:

The ohci vbus is fixed to 5v, and the over current pins of the
TPS are not connected. so this patch should be ok for
both the hawk and the lcdk.

Regards
Axel

> Thanks,
> Sekhar

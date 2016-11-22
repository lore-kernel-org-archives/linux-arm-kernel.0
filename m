From: ahaslam@baylibre.com (Axel Haslam)
Date: Tue, 22 Nov 2016 11:10:05 +0100
Subject: [PATCH 1/3] ARM: davinci: hawk: fix mmc card detect gpio
In-Reply-To: <8ced1194-4c68-7385-1594-0983855e7c89@ti.com>
References: <20161121161541.27048-1-ahaslam@baylibre.com>
 <20161121161541.27048-2-ahaslam@baylibre.com>
 <8ced1194-4c68-7385-1594-0983855e7c89@ti.com>
Message-ID: <CAKXjFTMW7p-TAehV_eTd4nDtC3gvNmcg-e9tLmv4LSX1LEXnhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2016 at 10:53 AM, Sekhar Nori <nsekhar@ti.com> wrote:
> On Monday 21 November 2016 09:45 PM, Axel Haslam wrote:
>> The card detect gpio on the hawk board is gpio4_0 and not gpio3_12
>>
>> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
>
> The LCDK and HawkBoard are different boards. The HawkBoard schematic
> from eLinux.org page is broken, but looking for it on the net, I found
> one and the MMC/SD CD pin in that schematic is indeed connected to GPIO3_12.
>
> So I believe the original code is correct.

mmm, ok, the lcdk is booted using the hawk board file,
so we should differentiate the two boards?
or should we just live with inconsistencies on the lcdk?

(im guessing the same will be ture for the usb)

Regards
Axel.
>
> Thanks,
> Sekhar
>

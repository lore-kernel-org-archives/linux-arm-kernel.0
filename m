From: ahaslam@baylibre.com (Axel Haslam)
Date: Tue, 25 Oct 2016 11:37:40 +0200
Subject: [PATCH/RFT v2 03/17] ARM: davinci: da8xx: Add USB PHY platform
 declaration
In-Reply-To: <4129f1be-42f6-f182-c8a2-84befe01d298@ti.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
 <20161024164634.4330-4-ahaslam@baylibre.com>
 <4129f1be-42f6-f182-c8a2-84befe01d298@ti.com>
Message-ID: <CAKXjFTPyxYLbPaOr8LPU8zRAqVYbVUSRyB0cj9vrA79cqEHocA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2016 at 11:18 AM, Sekhar Nori <nsekhar@ti.com> wrote:
> On Monday 24 October 2016 10:16 PM, ahaslam at baylibre.com wrote:
>> +static struct platform_device da8xx_usb_phy = {
>> +     .name           = "da8xx-usb-phy",
>> +     .id             = 0,
>
> There is a single phy control in the system for both 1.1 and 2.0 PHYs.
> so this can be a singular device (id -1).
>

Ok.

> Thanks,
> Sekhar
>

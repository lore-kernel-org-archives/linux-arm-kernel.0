From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Mon, 30 Jan 2017 18:11:40 -0800
Subject: [PATCH v3 21/24] media: imx: Add MIPI CSI-2 Receiver subdev driver
In-Reply-To: <20170131003129.GP27312@n2100.armlinux.org.uk>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-22-git-send-email-steve_longerbeam@mentor.com>
 <20170131003129.GP27312@n2100.armlinux.org.uk>
Message-ID: <8e5a9936-1713-62ff-ffaa-734bcbc2c507@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/30/2017 04:31 PM, Russell King - ARM Linux wrote:
> On Fri, Jan 06, 2017 at 06:11:39PM -0800, Steve Longerbeam wrote:
>> +++ b/drivers/staging/media/imx/imx-mipi-csi2.c
> ...
>> +#define DEVICE_NAME "imx6-mipi-csi2"
> Why is the device/driver named imx6-mipi-csi2, but the module named
> imx-mipi-csi2 - could there be some consistency here please?

right, that was missed after renaming the device node. Fixed.

Steve

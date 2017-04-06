From: frowand.list@gmail.com (Frank Rowand)
Date: Thu, 6 Apr 2017 11:46:07 -0700
Subject: [PATCH V10 00/12] IOMMU probe deferral support
In-Reply-To: <CAL_JsqJH9C9sNGBSLH88bJ=uKF7RibHDAUZUW9M2xeO2AM-FUw@mail.gmail.com>
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
 <1491301105-5274-1-git-send-email-sricharan@codeaurora.org>
 <CAL_JsqJH9C9sNGBSLH88bJ=uKF7RibHDAUZUW9M2xeO2AM-FUw@mail.gmail.com>
Message-ID: <58E68CEF.8090101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/17 18:23, Rob Herring wrote:
> On Tue, Apr 4, 2017 at 5:18 AM, Sricharan R <sricharan@codeaurora.org> wrote:
>> This series calls the dma ops configuration for the devices
>> at a generic place so that it works for all busses.
>> The dma_configure_ops for a device is now called during
>> the device_attach callback just before the probe of the
>> bus/driver is called. Similarly dma_deconfigure is called during
>> device/driver_detach path.
> 
> For patches 3, 4, 6, 7, 8:
> 
> Acked-by: Rob Herring <robh@kernel.org>
> .
> 

And a few hours later, I had the opposite opinion on a couple of
patches, so there is some ongoing discussion working this out.

-Frank

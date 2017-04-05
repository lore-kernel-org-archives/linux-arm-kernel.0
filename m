From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 4 Apr 2017 20:23:12 -0500
Subject: [PATCH V10 00/12] IOMMU probe deferral support
In-Reply-To: <1491301105-5274-1-git-send-email-sricharan@codeaurora.org>
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
 <1491301105-5274-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <CAL_JsqJH9C9sNGBSLH88bJ=uKF7RibHDAUZUW9M2xeO2AM-FUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 4, 2017 at 5:18 AM, Sricharan R <sricharan@codeaurora.org> wrote:
> This series calls the dma ops configuration for the devices
> at a generic place so that it works for all busses.
> The dma_configure_ops for a device is now called during
> the device_attach callback just before the probe of the
> bus/driver is called. Similarly dma_deconfigure is called during
> device/driver_detach path.

For patches 3, 4, 6, 7, 8:

Acked-by: Rob Herring <robh@kernel.org>

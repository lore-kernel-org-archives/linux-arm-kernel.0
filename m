From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 2 Aug 2016 10:45:46 +0200
Subject: [PATCH v3 0/2] Add support for Allwinner A64 mmc controller
In-Reply-To: <20160801151351.51854-1-icenowy@aosc.xyz>
References: <20160801151351.51854-1-icenowy@aosc.xyz>
Message-ID: <ce72fd4e-33c0-7ec4-c142-f6e057c1645d@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01-08-16 17:13, Icenowy Zheng wrote:
> Allwinner A64 has a slightly modified version of the Allwinner MMC controller.
>
> It do not have "output" or "sample" clock input, instead, it can calibrate the
> delay internally.
>
> This series of patch added the calibrate feature to the sunxi-mmc driver. It
> is based on works by Andre Przywara <andre.przywara@arm.com>, and now it
> depends on the patch set sent recently by Hans de Goede <hdegoede@redhat.com>,
> which disabled "output" and "sample" clock on A10/13.
> ( http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/446187.html )
>
> As the clock and device tree patch for Allwinner A64 is not yet merged, the
> patch set contains no patch to enable it.

Series looks good to me and is:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

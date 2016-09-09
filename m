From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 9 Sep 2016 12:12:14 +0200
Subject: [PATCH v4 0/2] Add support for Allwinner A64 mmc controller
In-Reply-To: <20160805025715.5306-1-icenowy@aosc.xyz>
References: <20160805025715.5306-1-icenowy@aosc.xyz>
Message-ID: <CAPDyKFpqFm0zZvK_0gqSy9iuvRGS6MTs9i4OMPC6OVZ8AvjRgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 August 2016 at 04:57, Icenowy Zheng <icenowy@aosc.xyz> wrote:
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

Thanks, series applied for next!

Kind regards
Uffe

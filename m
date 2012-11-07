From: tony@atomide.com (Tony Lindgren)
Date: Wed, 7 Nov 2012 10:24:05 -0800
Subject: [PATCH v4 0/3] ocp2scp: add non-dt support
In-Reply-To: <1351844088-27059-1-git-send-email-kishon@ti.com>
References: <1351844088-27059-1-git-send-email-kishon@ti.com>
Message-ID: <20121107182405.GH6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [121102 01:16]:
> This patch series allows ocp2scp driver to create its child devices
> from the platform data.
> 
> In omap platforms, usb phy is connected to ocp2scp and usb phy is needed
> for MUSB to be functional. When ocp2scp driver was added, it had only dt
> support which means it wont create usb phy devices for non-dt boot.
> 
> This patch series adds non-dt support to ocp2scp and this series is needed
> for getting MUSB functional in non-dt boot.

Thanks I've pushed these into omap-for-v3.7-rc4/musb-regression with
updated description to describe the regression for the -rc cycle.

Regards,

Tony

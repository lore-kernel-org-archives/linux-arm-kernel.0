From: alchark@gmail.com (Alexey Charkov)
Date: Thu, 19 Jul 2012 16:45:25 +0200
Subject: [PATCH 1/2] ARM: vt8500: Update vt8500-ehci driver to support
 device tree.
In-Reply-To: <1342704684-4858-1-git-send-email-linux@prisktech.co.nz>
References: <1342704684-4858-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <CABjd4YxfynH5f0dTwOh3EpiNr2vLq_2yJqys=Ztm_XV2oY4nsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/7/19 Tony Prisk <linux@prisktech.co.nz>:
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
>  drivers/usb/host/ehci-vt8500.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)

Have you tried to use ehci-platform on VIA/WMT devices? If it works
(which I would expect), I believe it's better to include OF support
into ehci-platform and drop ehci-vt8500 completely after existing
boards are converted to Device Tree. When writing ehci-vt8500, I
mostly only copied stuff from the PCI version and made it initialize
from the platform bus (nothing specific to vt8500).

Thanks,
Alexey

From: santosh.shilimkar@gmail.com (Santosh Shilimkar)
Date: Wed, 29 Oct 2014 12:07:14 -0700
Subject: [PATCH v1 0/4] Enable PCI controller for Keystone SoCs
In-Reply-To: <1414601134-31825-1-git-send-email-m-karicheri2@ti.com>
References: <1414601134-31825-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <54513AE2.6000304@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Murali,

On 10/29/2014 09:45 AM, Murali Karicheri wrote:
> Now that Keystone PCI driver is merged to v3.18, this patch series
> add build options and DTS bindings to enable the driver for Keystone SoCs.
>
> v1: resend with some minor fix up of the commit description and fixing
>      the email ID for Santosh.
>
> CC: Santosh Shilimkar <ssantosh@kernel.org>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Pawel Moll <pawel.moll@arm.com>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Ian Campbell <ijc+devicetree@hellion.org.uk>
> CC: Kumar Gala <galak@codeaurora.org>
> CC: Russell King <linux@arm.linux.org.uk>
> CC: devicetree at vger.kernel.org
>
> Murali Karicheri (4):
>    ARM: keystone: add pcie related options
>    ARM: keystone: defconfig: add options to enable PCI controller
>    ARM: dts: keystone: add DT bindings for PCI controller for port 0
>    ARM: dts: keystone-k2e: add DT bindings for PCI controller for port 1
>
Couple of minor comments o.w series looks fine by me. Once you
address the comment, please post updated version and I shall
queue that up for the next merge window.

Regards,
Santosh

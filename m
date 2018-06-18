From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 18 Jun 2018 09:37:04 -0700
Subject: [PATCH 2/3] ARM: dts: NSP: Fix PCIe controllers interrupt types
In-Reply-To: <20180611224714.7007-3-f.fainelli@gmail.com>
References: <20180611224714.7007-1-f.fainelli@gmail.com>
 <20180611224714.7007-3-f.fainelli@gmail.com>
Message-ID: <20180618163704.27123-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Jun 2018 15:47:13 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The interrupts for the PCIe controllers should all be of type
> IRQ_TYPE_LEVEL_HIGH instead of IRQ_TYPE_NONE.
> 
> Fixes: d71eb9412088 ("ARM: dts: NSP: Add MSI support on PCI")
> Fixes: 522199029fdc ("ARM: dts: NSP: Fix PCIE DT issue")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to devicetree/fixes, thanks!
--
Florian

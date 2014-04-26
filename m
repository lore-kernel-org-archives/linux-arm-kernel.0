From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 25 Apr 2014 20:27:58 -0400
Subject: [PATCHv3 3/5] ARM: mvebu: add Device Tree description of AHCI
 interfaces on Armada 38x
In-Reply-To: <1397574006-5868-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397574006-5868-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397574006-5868-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140426002758.GM28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 05:00:04PM +0200, Thomas Petazzoni wrote:
> The Marvell Armada 38x processors contain two AHCI compatible
> interfaces. This commit adds the Device Tree description of those
> interfaces at the SoC level, and also enables them on the Armada 385
> DB platform, which allows access to both interfaces through SATA
> ports.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-385-db.dts |  8 ++++++++
>  arch/arm/boot/dts/armada-38x.dtsi   | 16 ++++++++++++++++
>  2 files changed, 24 insertions(+)

Applied to mvebu/dt

thx,

Jason.

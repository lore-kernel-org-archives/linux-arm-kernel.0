From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Jun 2012 09:14:05 +0000
Subject: [PATCH v3 5/9] arm: mach-mvebu: add documentation for new device
 tree bindings
In-Reply-To: <1339746250-26650-6-git-send-email-gregory.clement@free-electrons.com>
References: <1339746250-26650-1-git-send-email-gregory.clement@free-electrons.com>
 <1339746250-26650-6-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <201206150914.05700.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 June 2012, Gregory Clement wrote:
> From: Gregory CLEMENT <gregory.clement@free-electrons.com>
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Signed-off-by: Lior Amsalem <alior@marvell.com>
> ---
>  .../devicetree/bindings/arm/armada_370_xp-mpic.txt |   23 +++++++++++++++++++
>  .../bindings/arm/armada_370_xp-timer.txt           |   11 +++++++++
>  .../devicetree/bindings/arm/armada_370_xp.txt      |   24 ++++++++++++++++++++
>  3 files changed, 58 insertions(+)

This is missing the new "system-controller" binding.

	Arnd

From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Jul 2012 20:40:34 +0000
Subject: [PATCH] arm: mvebu: generate DTBs for supported SoCs
In-Reply-To: <1342526360-8417-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1342526360-8417-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <201207172040.34835.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 July 2012, Thomas Petazzoni wrote:
> Add the necessary dtb-$(CONFIG_...) entries so that "make dtbs"
> generates the Device Tree Blobs that correspond to the selected mvebu
> SoCs.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied to next/newsoc branch.

	Arnd

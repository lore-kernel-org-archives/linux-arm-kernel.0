From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 11 Apr 2013 14:12:00 -0400
Subject: [PATCH v3 5/9] ARM: dts: Add a 64 bits version of the skeleton
 device tree
In-Reply-To: <1365461538-30702-6-git-send-email-gregory.clement@free-electrons.com>
References: <1365461538-30702-1-git-send-email-gregory.clement@free-electrons.com>
 <1365461538-30702-6-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130411181200.GP28693@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 09, 2013 at 12:52:13AM +0200, Gregory CLEMENT wrote:
> From: Lior Amsalem <alior@marvell.com>
> 
> In order to be able to use more than 4GB address-cells and size-cells
> have to be set to 2
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Lior Amsalem <alior@marvell.com>
> ---
>  arch/arm/boot/dts/skeleton64.dtsi |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 arch/arm/boot/dts/skeleton64.dtsi

Applied to mvebu/dt

Gregory,

Once I can pull in Thomas' pci work, you'll just need to rebase patches
1, and 6 - 9 against mvebu/dt.

thx,

Jason.

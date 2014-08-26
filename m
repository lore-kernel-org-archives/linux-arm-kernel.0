From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 26 Aug 2014 15:40:42 +0200
Subject: [PATCH v14 7/8] ARM: berlin: add the AHCI node for the BG2Q
In-Reply-To: <1406744041-1269-8-git-send-email-antoine.tenart@free-electrons.com>
References: <1406744041-1269-1-git-send-email-antoine.tenart@free-electrons.com>
 <1406744041-1269-8-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <53FC8E5A.9030404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2014 08:14 PM, Antoine T?nart wrote:
> The BG2Q has an AHCI SATA controller. Add the corresponding nodes
> (AHCI, PHY) into its device tree.
>
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> ---
>   arch/arm/boot/dts/berlin2q.dtsi | 39 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)

Applied to berlin/dt.

Thanks for the patience!

Sebastian

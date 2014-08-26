From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 26 Aug 2014 15:40:58 +0200
Subject: [PATCH v14 8/8] ARM: berlin: enable the eSATA interface on the
 BG2Q DMP
In-Reply-To: <1406744041-1269-9-git-send-email-antoine.tenart@free-electrons.com>
References: <1406744041-1269-1-git-send-email-antoine.tenart@free-electrons.com>
 <1406744041-1269-9-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <53FC8E6A.8020008@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2014 08:14 PM, Antoine T?nart wrote:
> The BG2Q has an AHCI SATA controller with an eSATA interface. Enable it.
> Only enable the first port, the BG2Q DMP does not support the second one.
>
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> ---
>   arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 8 ++++++++
>   1 file changed, 8 insertions(+)

Applied to berlin/dt.

Thanks for the patience!

Sebastian

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 2 Feb 2016 14:12:26 +0100
Subject: [PATCH 02/14] clk: sunxi: Add apb0 gates for A83T
In-Reply-To: <1454203266-4450-3-git-send-email-vishnupatekar0510@gmail.com>
References: <1454203266-4450-1-git-send-email-vishnupatekar0510@gmail.com>
 <1454203266-4450-3-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <20160202131226.GO4652@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 31, 2016 at 09:20:54AM +0800, Vishnu Patekar wrote:
> APB0 is part of PRCM, and is compatible with earlier SOCs.
> apb0 gates controls R_PIO, R_UART, R_RSB, etc clocks.
> This patch adds support for APB0 gates for A83T.
> 
> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160202/008ae378/attachment.sig>

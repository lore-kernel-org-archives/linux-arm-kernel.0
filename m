From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 30 Nov 2016 09:45:03 +0100
Subject: [PATCH 07/12] usb: sunxi: Uses the resource-managed extcon API
 when registering extcon notifier
In-Reply-To: <1480485460-2663-8-git-send-email-cw00.choi@samsung.com>
References: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
 <1480485460-2663-8-git-send-email-cw00.choi@samsung.com>
Message-ID: <20161130084503.v5klzl6silp6323s@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2016 at 02:57:35PM +0900, Chanwoo Choi wrote:
> This patch just uses the resource-managed extcon API when registering
> the extcon notifier.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161130/bc452c58/attachment.sig>

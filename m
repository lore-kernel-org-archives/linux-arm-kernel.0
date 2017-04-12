From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Apr 2017 14:42:33 +0200
Subject: [PATCH v4 14/18] arm: allwinner: pine64: Enable dwmac-sun8i
In-Reply-To: <20170412111400.2296-15-clabbe.montjoie@gmail.com>
References: <20170412111400.2296-1-clabbe.montjoie@gmail.com>
 <20170412111400.2296-15-clabbe.montjoie@gmail.com>
Message-ID: <20170412124233.6hpeekv4uzufklew@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 01:13:56PM +0200, Corentin Labbe wrote:
> The dwmac-sun8i hardware is present on the pine64
> It uses an external PHY via RMII.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

The architecture in your commit title in arm64, not arm (the next
patch also have this issue).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170412/8032d65e/attachment.sig>

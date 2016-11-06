From: vz@mleia.com (Vladimir Zapolskiy)
Date: Sun, 6 Nov 2016 03:37:06 +0200
Subject: [PATCH 13/22] mtd: nand: lpc32xx: return error code of
 nand_scan_ident/tail() on error
In-Reply-To: <1478256190-7452-14-git-send-email-yamada.masahiro@socionext.com>
References: <1478256190-7452-1-git-send-email-yamada.masahiro@socionext.com>
 <1478256190-7452-14-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <fab30f15-231a-f5fa-c547-025ee615b472@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/2016 12:43 PM, Masahiro Yamada wrote:
> The nand_scan_ident/tail() returns an appropriate error value when
> it fails.  Use it instead of the fixed error code -ENXIO.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

Thank you for the change.

--
With best wishes,
Vladimir

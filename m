From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 5 Nov 2016 08:34:26 +0100
Subject: [PATCH 00/22] mtd: nand: return error code of nand_scan(_ident,
 _tail) on error
In-Reply-To: <1478256190-7452-1-git-send-email-yamada.masahiro@socionext.com>
References: <1478256190-7452-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <7970b05b-a5d4-4149-ba80-f6d19a145c6d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/2016 11:42 AM, Masahiro Yamada wrote:
> 
> nand_scan(), nand_scan_ident(), nand_scan_tail() return
> an appropriate negative value on error.
> 
> Most of drivers return the value from them on error,
> but some of them return the fixed error code -ENXIO
> (and a few return -ENODEV).
> 
> This series make those drivers return more precise error code.
> 

Reviewed-by: Marek Vasut <marek.vasut@gmail.com>

Nice cleanup, thanks!

-- 
Best regards,
Marek Vasut

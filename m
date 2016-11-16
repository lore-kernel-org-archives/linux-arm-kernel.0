From: davem@davemloft.net (David Miller)
Date: Wed, 16 Nov 2016 13:28:51 -0500 (EST)
Subject: [PATCH v2 0/5] net: thunderx: Miscellaneous fixes
In-Reply-To: <1479211562-14170-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1479211562-14170-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <20161116.132851.1120462864756652814.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: sunil.kovvuri@gmail.com
Date: Tue, 15 Nov 2016 17:35:56 +0530

> This patchset includes fixes for incorrect LMAC credits,
> unreliable driver statistics, memory leak upon interface
> down e.t.c
> 
> Changes from v1:
> - As suggested replaced bit shifting with BIT() macro
>   in the patch 'Fix configuration of L3/L4 length checking'.

Series applied, thanks.

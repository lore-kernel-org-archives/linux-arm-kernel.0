From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 May 2012 14:20:28 +0000
Subject: [PATCH] ARM: clps711x: Using a single definition for the PHYS and
 VIRT registers offset
In-Reply-To: <1336281717-5332-1-git-send-email-shc_work@mail.ru>
References: <1335764876-14192-1-git-send-email-shc_work@mail.ru>
 <1336281717-5332-1-git-send-email-shc_work@mail.ru>
Message-ID: <201205111420.28307.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 06 May 2012, Alexander Shiyan wrote:
> Using a single definition for the physical and virtual address register for all
> variants boards clps711x. This patch also includes the use of a single function
> clps_read/write in some units.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied to the clps711x/cleanup branch and pulled into next/cleanup

Thanks,

	Arnd

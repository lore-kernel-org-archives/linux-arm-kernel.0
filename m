From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Dec 2011 23:52:57 +0100
Subject: [PATCH v4 1/6] ARM: versatile: Add missing ENDPROC to headsmp.S
In-Reply-To: <1323186229-22054-2-git-send-email-pawel.moll@arm.com>
References: <1323186229-22054-1-git-send-email-pawel.moll@arm.com>
 <1323186229-22054-2-git-send-email-pawel.moll@arm.com>
Message-ID: <5029402.jHt85riLEg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 December 2011 15:43:44 Pawel Moll wrote:
> Once the ENDPROC is in place, BSYM() in not longer necessary
> to get correct pointer to versatile_secondary_startup().
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

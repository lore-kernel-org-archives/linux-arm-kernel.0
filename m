From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Mar 2013 17:30:23 +0000
Subject: [PATCH v3 for 3.10] Introduce a Marvell EBU MBus driver
In-Reply-To: <1363885160-6870-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1363885160-6870-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <201303211730.23247.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 March 2013, Thomas Petazzoni wrote:
> Changes since v2:
> 
>  * Remove the DT binding, and use the mvebu_mbus_init() function call
>    in all Marvell EBU SoC families. Requested by Arnd Bergmann.
> 
>  * Fix the MV78xx0 code, after reports of issues by Gregory Clement
>    when testing on this platform.
> 
>  * Remove the 3 patches that have been merged by Arnd in
>    arm-soc/mvebu-cleanup.
> 

Thanks for the update

Acked-by: Arnd Bergmann <arnd@arndb.de>

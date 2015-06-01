From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Jun 2015 17:43:23 +0200
Subject: [GIT PULL] Broadcom Device Tree changes for 4.2 (fixes)
In-Reply-To: <1432936488-20408-1-git-send-email-f.fainelli@gmail.com>
References: <1432936488-20408-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1907612.xnZQlYLyqA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 May 2015 14:54:48 Florian Fainelli wrote:
> This pull request contains a single change:
> 
> - fix the NAND controller node on bcm63138, the original change was a mis-merge that
>   did not properly parent it to the "ubus" node
> 

Pulled into next/dt, thanks!

	Arnd

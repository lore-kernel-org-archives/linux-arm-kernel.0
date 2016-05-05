From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 05 May 2016 23:05:04 +0200
Subject: [PATCH 6/6] arm: dt: bcm23550: Add device tree files
In-Reply-To: <1462481334-8943-7-git-send-email-chris.brand@broadcom.com>
References: <1462481334-8943-1-git-send-email-chris.brand@broadcom.com>
 <1462481334-8943-7-git-send-email-chris.brand@broadcom.com>
Message-ID: <9191808.kbIrFQuH7z@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 May 2016 13:48:54 Chris Brand wrote:
> +
> +       chosen {
> +               bootargs = "console=ttyS0,115200n8";
> +       };
> +
> 

Can you move this into the .dts file, and add a stdout-path
property to make earlycon work?

	Arnd

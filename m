From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Sep 2014 18:09:31 +0200
Subject: [PATCH v1 3/4] arm: pxa: remove unecessary includes from pxa-dt
In-Reply-To: <1411973508-14301-3-git-send-email-robert.jarzmik@free.fr>
References: <1411973508-14301-1-git-send-email-robert.jarzmik@free.fr>
 <1411973508-14301-3-git-send-email-robert.jarzmik@free.fr>
Message-ID: <10180212.jXII7qFdeU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 September 2014 08:51:47 Robert Jarzmik wrote:
>  #ifdef CONFIG_PXA3xx
> -extern void __init pxa3xx_dt_init_irq(void);
> -
> 

Nice catch.

	Arnd

From: davem@davemloft.net (David Miller)
Date: Thu, 11 Feb 2016 11:30:53 -0500 (EST)
Subject: [PATCH v2 0/6] net: thunderx: Setting IRQ affinity hints and
 other optimizations
In-Reply-To: <1455207626-35488-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1455207626-35488-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <20160211.113053.1221794797998213409.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: sunil.kovvuri@gmail.com
Date: Thu, 11 Feb 2016 21:50:20 +0530

> This patch series contains changes
> - To add support for virtual function's irq affinity hint
> - Replace napi_schedule() with napi_schedule_irqoff()
> - Reduce page allocation overhead by allocating pages
>   of higher order when pagesize is 4KB.
> - Add couple of stats which helps in debugging
> - Some miscellaneous changes to BGX driver.
> 
> Changes from v1:
> - As suggested changed MAC address invalid log message 
>   to dev_err() instead of dev_warn().

Series applied, thanks.

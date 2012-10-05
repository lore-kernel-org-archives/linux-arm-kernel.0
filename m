From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Oct 2012 19:53:42 +0000
Subject: [PATCH 00/10] Platform data clean-up and UIB device enablement
In-Reply-To: <1349451107-8009-1-git-send-email-lee.jones@linaro.org>
References: <1349451107-8009-1-git-send-email-lee.jones@linaro.org>
Message-ID: <201210051953.43586.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 October 2012, Lee Jones wrote:
> In this patch-set we move all Device Tree start-up code from the u8500
> board file and into the more persistent db8500 cpu file. This will aid
> future endeavours to remove platform code completely from Mainline. We
> also enable some of the devices found on the STUIB (User Interface
> board), which attaches to some of ST-Ericsson's reference platforms.
> 

Looks all good to me.

Acked-by: Arnd Bergmann <arnd@arndb.de>

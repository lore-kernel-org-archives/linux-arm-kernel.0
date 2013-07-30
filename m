From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 30 Jul 2013 10:03:56 +0200
Subject: [PATCH 4/4] ARM: dove: add initial DT file for Globalscale D2Plug
In-Reply-To: <20130729184520.GI24782@lunn.ch>
References: <1375100946-28521-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1375100946-28521-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130729184520.GI24782@lunn.ch>
Message-ID: <51F7736C.5040701@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2013 08:45 PM, Andrew Lunn wrote:
> On Mon, Jul 29, 2013 at 02:29:06PM +0200, Sebastian Hesselbarth wrote:
>> This adds an initial DT file for the Globalscale D2Plug with Dove SoC.
>> Currently, one LED is missing and I have not been able to get SD8787 driver
>> working. Those will be taken care of later.
>
> I took a hard look at SDIO and failed to get it working when doing
> DMA. Polled IO does however work. I guess we need some help from
> Marvell engineers before we get stable SDIO with DMA.

Andrew,

have you tried this on the Dove D2Plug or any other Marvell SoC?
Dove is using a different SDHCI compatible SDIO controller.

Anyway, I haven't had a deep look into neither SDIO/SDHCI DMA nor
sd8787 driver.

Also, the DMA issue is not holding back this patch, is it?

Sebastian

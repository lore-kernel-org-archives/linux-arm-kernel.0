From: andy@warmcat.com (Andy Green)
Date: Wed, 16 Mar 2011 07:22:58 +0000
Subject: [PATCH 3 00/18] I2C: OMAP1: OMAP2+: I2C fixes,
	removal of	cpu_is... from driver
In-Reply-To: <20110315222813.GL7258@atomide.com>
References: <20110315195147.30000.86184.stgit@otae.warmcat.com>
	<20110315222813.GL7258@atomide.com>
Message-ID: <4D806552.5040701@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/15/2011 10:28 PM, Somebody in the thread at some point said:
> Hi,
>
> * Andy Green<andy@warmcat.com>  [110315 12:53]:
>> The following series removes cpu_...() usage completely from the
>> omap-i2c driver by having decisions about functional implementation
>> choices in the SoC held in cpu-specific hwmod tables that are
>> already established, or for OMAP1 where there is no hwmod, set at
>> OMAP1-specific i2c bus addition time.
>
> You should send this to the i2c list with Ben Cc'd.

Done... sorry for the fumble.  Ben is already CC'd, sorry for spamming 
his mailbox too.

-Andy

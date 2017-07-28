From: david.wu@rock-chips.com (David.Wu)
Date: Fri, 28 Jul 2017 15:48:10 +0800
Subject: [PATCH v2 01/11] net: phy: Add rockchip phy driver support
In-Reply-To: <20170727133800.GC18666@lunn.ch>
References: <1501160156-30328-1-git-send-email-david.wu@rock-chips.com>
 <1501160156-30328-2-git-send-email-david.wu@rock-chips.com>
 <20170727133800.GC18666@lunn.ch>
Message-ID: <71a83db0-61e1-5852-30af-526d8a5d2c60@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

? 2017/7/27 21:38, Andrew Lunn ??:
>> +	/*
>> +	 * If mode switch happens from 10BT to 100BT, all DSP/AFE
>> +	 * registers are set to default values. So any AFE/DSP
>> +	 * registers have to be re-initialized in this case.
>> +	 */
> 
> Hi David
> 
> Are they also lost on suspend and resume?

Yes, i will add the re-initialized on suspend and resume?and thank you?

> 
>      Andrew
> 
> 
> 

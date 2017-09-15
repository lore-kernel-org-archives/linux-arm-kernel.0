From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 15 Sep 2017 09:49:41 +0200
Subject: [PATCH] net: phy: Fix mask value write on gmii2rgmii converter
 speed register.
In-Reply-To: <20170914143454.GB27601@lunn.ch>
References: <1505373391-18697-1-git-send-email-fahad.kunnathadi@dexceldesigns.com>
 <20170914143454.GB27601@lunn.ch>
Message-ID: <5f4bd003-d251-5a14-497a-9cc72dd0f160@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.9.2017 16:34, Andrew Lunn wrote:
> On Thu, Sep 14, 2017 at 12:46:31PM +0530, Fahad Kunnathadi wrote:
>> To clear Speed Selection in MDIO control register(0x10),
>> ie, clear bits 6 and 13 to zero while keeping other bits same.
>> Before AND operation,The Mask value has to be perform with bitwise NOT
>> operation (ie, ~ operator)
>>
>> This patch clears current speed selection before writing the
>> new speed settings to gmii2rgmii converter
> 
> Hi Fahad
> 
> I expect you will find other issues with this driver. I pointed some
> out at the time it is submitted, but the developers went quiet as soon
> as it was accepted.

Can you please point me to that email?
I will create ticket about it in our system to get them resolved.

Thanks,
Michal

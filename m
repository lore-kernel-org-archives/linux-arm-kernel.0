From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 13 Dec 2013 16:52:53 +0530
Subject: [PATCH] phy: Add exynos-phy driver
In-Reply-To: <52A83B87.205@samsung.com>
References: <1385558788-10880-1-git-send-email-t.stanislaws@samsung.com>
 <52A8364B.5020204@ti.com> <52A83B87.205@samsung.com>
Message-ID: <52AAEE0D.7010203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 11 December 2013 03:46 PM, Sylwester Nawrocki wrote:
> On 11/12/13 10:54, Kishon Vijay Abraham I wrote:
>> On Wednesday 27 November 2013 06:56 PM, Tomasz Stanislawski wrote:
>>>> Hello everyone,
>>>> The Samsung SoCs from Exynos family are enhanced with a bunch of switches
>>>> dedicated for IP blocks. Those switches are called PHYs in Exynos
>>>> specification. They are usually controlled by a single bit in a single
>>>> one-word-long register.
>>
>> So only enabling this switch is enough for the controller or some other actual
>> PHY IP is needed along with this switch?
>>
>> However I'm not sure if the switch should be modelled as PHY as it is not a PHY
>> in the real sense.
> 
> These are ordinary PHY devices embedded in an SoC. I wouldn't really call
> them "switches", as they indeed provide the physical layer functionality 
> for various interfaces, like USB, HDMI, MIPI CSI/DSI, etc. Their control 

Are they used along with the phy IPs for which Kamil and others have sent
patches or this is used in different SoCs from what Kamil uses?

Thanks
Kishon

> interface is often very simple - usually only an enable and a reset 
> control bit. But that can't change the fact they are real PHY devices,
> so let's not call them switches, that's just untrue.
> 
> Regards,
> Sylwester
> 

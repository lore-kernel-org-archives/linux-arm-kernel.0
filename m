From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Wed, 02 Mar 2011 20:41:22 -0800
Subject: [Qualcomm PM8921 MFD 5/6] MAINTAINERS: Add pmic8921, pmic8xxx
	subdevices maintainers
In-Reply-To: <1299106213.4208.112.camel@Joe-Laptop>
References: <1299104001-5240-1-git-send-email-adharmap@codeaurora.org>	
	<1299104001-5240-6-git-send-email-adharmap@codeaurora.org>
	<1299106213.4208.112.camel@Joe-Laptop>
Message-ID: <4D6F1BF2.5080908@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joe Perches wrote:
> On Wed, 2011-03-02 at 14:13 -0800, adharmap at codeaurora.org wrote:
>> diff --git a/MAINTAINERS b/MAINTAINERS
> 
> The patch subject is not quite correct.
> You're adding patterns, not maintainers.

Ok will fix it in the next patch series.

> Another option is a wildcard pattern match like:
> 
> F:	drivers/*/pm8???-*
> 
> instead of:
> 
> F:	drivers/gpio/pm8xxx-gpio.c
> F:	drivers/mfd/pm8921-core.c
> F:	drivers/mfd/pm8xxx-irq.c
> F:	drivers/mfd/pm8xxx-mpp.c

Will do, thanks for this wildcard pattern

--
Sent by an employee of the Qualcomm Innovation Center, Inc. The Qualcomm 
Innovation Center, Inc. is a member of the Code Aurora Forum.

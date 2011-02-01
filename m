From: michael.williamson@criticallink.com (Michael Williamson)
Date: Tue, 01 Feb 2011 07:43:13 -0500
Subject: [PATCH 4/4] davinci: add spi devices support for
	da830/omap-l137/am17x evm
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930248777A33@dbde02.ent.ti.com>
References: <1296518716-5004-1-git-send-email-michael.williamson@criticallink.com>	<1296518716-5004-5-git-send-email-michael.williamson@criticallink.com>
	<4D47F74B.9060309@mvista.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930248777A33@dbde02.ent.ti.com>
Message-ID: <4D47FFE1.6040901@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

On 2/1/2011 7:11 AM, Nori, Sekhar wrote:

> On Tue, Feb 01, 2011 at 17:36:35, Sergei Shtylyov wrote:
>> Hello.
>>
>> On 01-02-2011 3:05, Michael Williamson wrote:
>>
>>> From: Sekhar Nori<nsekhar@ti.com>
>>
>>> This patch adds the on-board SPI flash device to the
>>> DA830/OMAP-L137/AM17x EVM. It also registers the SPI flash
>>> device to the MTD subsystem.
>>
>>> Based on SPI flash device support for MityDSP-L138F platform.
>>
>>> Signed-off-by: Michael Williamson<michael.williamson@criticallink.com>
>>
>>     Why Sekhar hasn't signed off on this patch?
> 
> I should have.
> 
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> 
> Thanks,
> Sekhar
> 


I need to move the da830evm_spi0_pdata structure into the common devices-da8xx.c
based on your other comment to part 2/4 of this series.  

For my clarification on patch submission, do I need to change the authorship if
I touch it in anyway?  Or should I leave you the author (given you ack the mods, 
and confirm your sign-off)?

Thanks.

-Mike

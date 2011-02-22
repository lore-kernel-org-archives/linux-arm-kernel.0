From: michael.williamson@criticallink.com (Michael Williamson)
Date: Tue, 22 Feb 2011 07:13:29 -0500
Subject: [PATCH v2 3/6] davinci: da8xx: add spi resources and registration
	routine
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024BD48E7B@dbde02.ent.ti.com>
References: <1297257114-764-1-git-send-email-michael.williamson@criticallink.com>
	<1297257114-764-4-git-send-email-michael.williamson@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024BD48E7B@dbde02.ent.ti.com>
Message-ID: <4D63A869.1070401@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/22/2011 1:14 AM, Nori, Sekhar wrote:

> Hi Mike,
> 
> On Wed, Feb 09, 2011 at 18:41:51, Michael Williamson wrote:
>> Add IO resource structures, platform data, and a registration
>> routine in order to support spi device on DA850/OMAP-L138/AM18x
>> and DA830/OMAP-L137/AM17x platforms.
>>
>> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
> 
> [...]
> 
>> +static struct resource da8xx_spi1_resources[] = {
>> +	[0] = {
>> +		.start	= DA8XX_SPI1_BASE,
>> +		.end	= DA8XX_SPI1_BASE + SZ_4K -1,
> 
> checkpatch reports a warning here. Need to have spaces
> on either side of binary '-'
> 


Sorry about that... not sure how I missed that one.

> I tested this series and the two patches it depends on
> using SPI flash present on DA850 and DA830 EVMs (tested
> in DMA mode) and found no issues.
> 


Thanks for testing, Sekhar.

> So, with this minor issue fixed, can you please repost
> with my Ack? You can include the two dependent patches
> in the same series so it is easy to pick-up the whole
> bunch.
> 


OK.

> Thanks,
> Sekhar
> 

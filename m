From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 8 Jul 2014 18:43:26 +0530
Subject: [PATCH v9 1/7] phy: add a driver for the Berlin SATA PHY
In-Reply-To: <53BBEB84.50904@gmail.com>
References: <1404728173-20263-1-git-send-email-antoine.tenart@free-electrons.com>
 <1404728173-20263-2-git-send-email-antoine.tenart@free-electrons.com>
 <53BBE419.8080107@ti.com> <53BBEB84.50904@gmail.com>
Message-ID: <53BBEE76.7090100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 08 July 2014 06:30 PM, Sebastian Hesselbarth wrote:
> On 07/08/2014 02:29 PM, Kishon Vijay Abraham I wrote:
>> On Monday 07 July 2014 03:46 PM, Antoine T?nart wrote:
>>> The Berlin SoC has a two SATA ports. Add a PHY driver to handle them.
>>>
>>> The mode selection can let us think this PHY can be configured to fit
>>> other purposes. But there are reasons to think the SATA mode will be
>>> the only one usable: the PHY registers are only accessible indirectly
>>> through two registers in the SATA range, the PHY seems to be integrated
>>> and no information tells us the contrary. For these reasons, make the
>>> driver a SATA PHY driver.
>>
>> Thanks for doing multiple revisions of this. Looks good to be merged for me now.
> 
> I'd like to see some Acked-by from Tejun on the AHCI patches first, but
> if he agrees, should I prepare a stable branch for each of us to pull
> their patches from?

I don't think that's needed. As long as there are no build breaks, each of us
should be able to take it independently.
> 
> AFAIKS, that would be 1+2 for you, 3-5 for Tejun, and the DT crap 6+7
> for me.

right, I'll take 1 and 2 in my tree.

Cheers
Kishon

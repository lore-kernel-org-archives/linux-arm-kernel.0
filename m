From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 12 Apr 2012 21:24:29 +0200
Subject: [PATCH v4 0/7] Add TI EMIF SDRAM controller driver
In-Reply-To: <alpine.DEB.2.00.1204121304050.29473@utopia.booyaka.com>
References: <1331934707-29487-1-git-send-email-aneesh@ti.com>
 <alpine.DEB.2.00.1204112042070.29473@utopia.booyaka.com>
 <20120412030044.GA26236@kroah.com> <4F867A95.9030104@ti.com>
 <20120412131045.GB31384@kroah.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E95947E@DQHE04.ent.ti.com>
 <alpine.DEB.2.00.1204121053570.29473@utopia.booyaka.com>
 <4F87240F.6060902@ti.com>
 <alpine.DEB.2.00.1204121304050.29473@utopia.booyaka.com>
Message-ID: <4F872BED.7000703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/12/2012 9:15 PM, Paul Walmsley wrote:
> Hi Beno?t,
>
> On Thu, 12 Apr 2012, Cousson, Benoit wrote:
>
>> The LPDDR2 spec does consider as well NVM (Non Volatile Memory), so I think we
>> should stick to driver/memory for EMIF.
>
> Hmm good point!
>
>>> So perhaps something like drivers/memory/dram/ for the SDRAM controllers,
>>> and maybe drivers/memory/ for the GPMC?
>>
>> In fact Felipe was considering something else for that kind of general purpose
>> bus driver like GMPC, C2C and LLI...
>>
>> ... But I do not remember the name :-)
>
> It would be nice if we could separate IP blocks that can drive an Ethernet
> controller or modem chip from the DRAM controllers; they are quite
> different beasts from a common API standpoint.

Yep, fully agree. In fact Felipe's suggestion was something like 
drivers/ocd for off-chip devices, but maybe something like drivers/gpbus 
will highlight a little bit more the bus controller aspect of such driver.

Regards,
Benoit

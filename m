From: julian.calaby@gmail.com (Julian Calaby)
Date: Mon, 4 May 2015 13:22:03 +1000
Subject: [PATCH v3 2/2] ata: ahci_xgene: Add AHCI Support for 2nd HW
 version of APM X-Gene SoC AHCI SATA Host controller.
In-Reply-To: <CAOHikRDsnywXaSW8XZiOq-uq9fHiwhp0uxXzHF-ysUO_VmQYFw@mail.gmail.com>
References: <1430667220-23477-1-git-send-email-stripathi@apm.com>
 <1430667220-23477-3-git-send-email-stripathi@apm.com>
 <CAGRGNgWGk9jkg3Kui5BdFNhpCKOhD=SCW4apmzqMNHKfVbKMmw@mail.gmail.com>
 <CAOHikRDsnywXaSW8XZiOq-uq9fHiwhp0uxXzHF-ysUO_VmQYFw@mail.gmail.com>
Message-ID: <CAGRGNgX8d0vMDzTH2mPnkwgBk7RJGWVReSyMC3nS=G0z0XvdYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

On Mon, May 4, 2015 at 12:51 PM, Suman Tripathi <stripathi@apm.com> wrote:
> Hi Julian.
>
> On Mon, May 4, 2015 at 5:56 AM, Julian Calaby <julian.calaby@gmail.com> wrote:
>> Hi Suman,
>>
>> On Mon, May 4, 2015 at 1:33 AM, Suman Tripathi <stripathi@apm.com> wrote:
>>> This patch enables full AHCI feature support for APM X-Gene SoC SATA
>>> host controller. The following errata's are removed:
>>>
>>> 1. 2a0bdff6b95 ("ahci-xgene: fix the dma state machine lockup for the
>>>                  IDENTIFY DEVICE PIO mode command")
>>> 2. 09c32aaa368 ("ahci_xgene: Fix the dma state machine lockup for the
>>>                  ATA_CMD_SMART PIO mode command")
>>> 3. 1540035da71 ("ahci_xgene: Implement the xgene_ahci_poll_reg_val to
>>>                  support PMP")
>>> 4. a3a84bc7c88 ("ahci_xgene: Implement the workaround to support PMP
>>>                  enumeration and discovery")
>>> 5. 1102407bb71 ("ahci_xgene: Fix the DMA state machine lockup for the
>>>                  ATA_CMD_PACKET PIO mode command")
>>> 6. 72f79f9e35b ("ahci_xgene: Removing NCQ support from the APM X-Gene
>>>                 SoC AHCI SATA Host Controller driver")
>>
>> Won't this mean that the 1st HW version won't work properly?
>
> No it doesn't mean that, It means whatever workaround we had in 1st HW
> version has been
> fixed in 2nd HW version.

I'm sorry, I read the description and assumed that these fixes were
being removed from the driver, hence breaking support for the 1st
hardware version.

Sorry for the confusion.

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

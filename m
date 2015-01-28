From: stripathi@apm.com (Suman Tripathi)
Date: Wed, 28 Jan 2015 09:54:21 +0530
Subject: [PATCH] ahci_xgene: Fix the dma state machine lockup for the
 ATA_CMD_SMART PIO mode command.
In-Reply-To: <20150127181950.GE12314@htj.dyndns.org>
References: <1422381371-11361-1-git-send-email-stripathi@apm.com>
 <1422381371-11361-2-git-send-email-stripathi@apm.com>
 <20150127181950.GE12314@htj.dyndns.org>
Message-ID: <CAOHikRBBG2p7kBn=bwP9rw0RYecvjNqz-zAiHeKT4+TyP8sCoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 11:26:11PM +0530, Suman Tripathi wrote:
> This patch addresses the issue with ATA_CMD_SMART pio mode
> command for enumeration and device detection with ATA devices.It is the
> same issue as in patch
>
> www.spinics.net/lists/linux-ide/msg49092.html

The link is broken.  Can you please include at least a brief
explanation of the problem and preferably link to something more
permanant (commit ID, http://lkml.kernel.org/g/MSG_ID)?
Ok some problem might be there, But the link is opening. Sure I will
add the explanation rather than providing a link in the next version


On Tue, Jan 27, 2015 at 11:49 PM, Tejun Heo <tj@kernel.org> wrote:
> On Tue, Jan 27, 2015 at 11:26:11PM +0530, Suman Tripathi wrote:
>> This patch addresses the issue with ATA_CMD_SMART pio mode
>> command for enumeration and device detection with ATA devices.It is the
>> same issue as in patch
>>
>> www.spinics.net/lists/linux-ide/msg49092.html
>
> The link is broken.  Can you please include at least a brief
> explanation of the problem and preferably link to something more
> permanant (commit ID, http://lkml.kernel.org/g/MSG_ID)?
>
> Thanks.
>
> --
> tejun



-- 
Thanks,
with regards,
Suman Tripathi

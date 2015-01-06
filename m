From: stripathi@apm.com (Suman Tripathi)
Date: Tue, 6 Jan 2015 13:51:15 +0530
Subject: [PATCH 2/2] ahci_xgene: Fix the dma state machine lockup for the
 ATA_CMD_PACKET PIO mode command.
In-Reply-To: <20150105135910.GD15833@htj.dyndns.org>
References: <1418748575-27301-1-git-send-email-stripathi@apm.com>
 <1418748575-27301-3-git-send-email-stripathi@apm.com>
 <20150105135910.GD15833@htj.dyndns.org>
Message-ID: <CAOHikRDXvN2guikwBr8E+pdRsm9UKeqMCA7LStGCxOMWRvHdBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Tue, Dec 16, 2014 at 10:19:35PM +0530, Suman Tripathi wrote:
> This patch addresses the issue with ATA_CMD_PACKET pio mode
> command for enumeration and device detection with ATAPI devices.It is the
> same issue as in patch
>
> www.spinics.net/lists/linux-ide/msg49092.html
>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>

Applied 1-2 to libata/for-3.18-fixes w/ Sergei's suggested edits.

The patch is applied to libata/for-3.19-fixes not libata/for-3.18-fixes ??

On Mon, Jan 5, 2015 at 7:29 PM, Tejun Heo <tj@kernel.org> wrote:
> On Tue, Dec 16, 2014 at 10:19:35PM +0530, Suman Tripathi wrote:
>> This patch addresses the issue with ATA_CMD_PACKET pio mode
>> command for enumeration and device detection with ATAPI devices.It is the
>> same issue as in patch
>>
>> www.spinics.net/lists/linux-ide/msg49092.html
>>
>> Signed-off-by: Suman Tripathi <stripathi@apm.com>
>
> Applied 1-2 to libata/for-3.18-fixes w/ Sergei's suggested edits.
>
> Thanks.
>
> --
> tejun



-- 
Thanks,
with regards,
Suman Tripathi
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, 
is for the sole use of the intended recipient(s) and contains information
that is confidential and proprietary to Applied Micro Circuits Corporation or its subsidiaries. 
It is to be used solely for the purpose of furthering the parties' business relationship. 
All unauthorized review, use, disclosure or distribution is prohibited. 
If you are not the intended recipient, please contact the sender by reply e-mail 
and destroy all copies of the original message.

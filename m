From: tchalamarla@caviumnetworks.com (Tirumalesh Chalamarla)
Date: Mon, 29 Feb 2016 14:00:00 -0800
Subject: [PATCH V3] AHCI: Workaround for ThunderX Errata#22536
In-Reply-To: <20160229211704.GA3965@htj.duckdns.org>
References: <1455653329-4934-1-git-send-email-tchalamarla@caviumnetworks.com>
 <20160229211704.GA3965@htj.duckdns.org>
Message-ID: <56D4BF60.8010508@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks.


On 02/29/2016 01:17 PM, Tejun Heo wrote:
> On Tue, Feb 16, 2016 at 12:08:49PM -0800, tchalamarla at caviumnetworks.com wrote:
>> From: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
>>
>> Due to Errata in ThunderX, HOST_IRQ_STAT should be
>> cleared before leaving the interrupt handler.
>> The patch attempts to satisfy the need.
>>
>> Changes from V2:
>> 	- removed newfile
>> 	- code is now under CONFIG_ARM64
>>
>> Changes from V1:
>> 	- Rebased on top of libata/for-4.6
>>          - Moved ThunderX intr handler to new file
>>
>> Signed-off-by: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
>
> Applied to libata/for-4.5-fixes w/ minor adjustments to comments.
>
> Thanks.
>

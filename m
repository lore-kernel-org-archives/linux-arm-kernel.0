From: stripathi@apm.com (Suman Tripathi)
Date: Wed, 10 Feb 2016 10:59:31 -0800
Subject: [PATCH v4 0/3] ata: Fixes related to edge trigger latch for the
 ahci_xgene_driver.
In-Reply-To: <20160210162547.GJ3741@mtj.duckdns.org>
References: <1454738124-9351-1-git-send-email-stripathi@apm.com>
 <20160210162547.GJ3741@mtj.duckdns.org>
Message-ID: <CAOHikRBNL2gLJwhB2SEKJXZtOpmqwBET4P9RgRrPdhyH4bn0zA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tejun,

On Wed, Feb 10, 2016 at 8:25 AM, Tejun Heo <tj@kernel.org> wrote:
> On Sat, Feb 06, 2016 at 11:25:21AM +0530, suman Tripathi wrote:
>> From: Suman Tripathi <stripathi@apm.com>
>>
>> This patch set implements a workaround for an errate in the APM
>> X-Gene SATA host controller with edge interrupt. The HOST_IRQ_STAT
>> misses the edge interrupt from the PORT_IRQ_STAT when clearing the
>> HOST_IRQ_STAT and reporting the PORT_IRQ_STAT happens in same clock
>> cycle. It also implements the capability to override generic interrupt
>> handler.
>
> Applied 1-3 to libata/for-4.6 with minor updates.

will this patchset  go to 4.5 ?

>
> Thanks.
>
> --
> tejun



-- 
Thanks,
with regards,
Suman Tripathi

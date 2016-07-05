From: adrian.hunter@intel.com (Adrian Hunter)
Date: Tue, 5 Jul 2016 09:06:11 +0300
Subject: [PATCH 0/2] mmc: sdhci-iproc: Use defines instead of magic numbers
In-Reply-To: <577A968C.3020107@broadcom.com>
References: <1467487394-28682-1-git-send-email-stefan.wahren@i2se.com>
 <577A968C.3020107@broadcom.com>
Message-ID: <577B4E53.6030000@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/16 20:02, Scott Branden wrote:
> Hi Stefan,
> 
> On 16-07-02 12:23 PM, Stefan Wahren wrote:
>> Hi,
>>
>> this small patch series should make the sdhci-iproc platform data easier
>> to read. Since i don't have the adequate hardware it's only compile tested.
>>
>> Stefan
>>
>> Stefan Wahren (2):
>>    mmc: sdhci: add define for suspend/resume capability
>>    mmc: sdhci-iproc: Use defines instead of magic numbers
>>
>>   drivers/mmc/host/sdhci-iproc.c |   13 +++++++++++--
>>   drivers/mmc/host/sdhci.h       |    1 +
>>   2 files changed, 12 insertions(+), 2 deletions(-)
>>
> Patch series looks fine.
> 
> Acked-by: Scott Branden <scott.branden@broadcom.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

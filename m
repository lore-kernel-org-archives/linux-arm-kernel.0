From: ahaslam@baylibre.com (Axel Haslam)
Date: Thu, 3 Nov 2016 13:19:20 +0100
Subject: [PATCH 3/3] usb: ohci-da8xx: rename driver to ohci-da8xx
In-Reply-To: <a1b45345-ef63-ad6a-a755-57881355049d@ti.com>
References: <20161102124435.31777-1-ahaslam@baylibre.com>
 <20161102124435.31777-4-ahaslam@baylibre.com>
 <a1b45345-ef63-ad6a-a755-57881355049d@ti.com>
Message-ID: <CAKXjFTMXwzhBve40J8hVtc=m7wxTWt2s499MCMM=SkT--Y_KMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

The baseline used was the branch usb-next, in Greg's tree:
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git

Linux next is missing this patch[1] which was applied last week,
but not yet pulled into linux-next. it will be there soon.

Sorry, i did not mention it, i thought it would be already
on linux-next.

[1]
6c21caa USB: OHCI: make ohci-da8xx a separate driver
https://lkml.org/lkml/2016/10/27/120

Regards
Axel



On Thu, Nov 3, 2016 at 12:56 PM, Sekhar Nori <nsekhar@ti.com> wrote:
> On Wednesday 02 November 2016 06:14 PM, Axel Haslam wrote:
>> To be consistent on the usb driver for the davinci
>> platform follow the example of musb, and add the
>> "-da8xx" postfix to the driver name.
>>
>> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
>> ---
>>  drivers/usb/host/ohci-da8xx.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
>> index bd6cf3c..b3de8bc 100644
>> --- a/drivers/usb/host/ohci-da8xx.c
>> +++ b/drivers/usb/host/ohci-da8xx.c
>> @@ -27,7 +27,7 @@
>>  #include "ohci.h"
>>
>>  #define DRIVER_DESC "DA8XX"
>> -#define DRV_NAME "ohci"
>> +#define DRV_NAME "ohci-da8xx"
>
> To which baseline does this patch apply? I don't see this code in
> linux-next.
>
> Thanks,
> Sekhar

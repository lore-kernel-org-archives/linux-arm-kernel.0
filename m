From: john.tobias.ph@gmail.com (John Tobias)
Date: Thu, 24 Jul 2014 11:40:28 -0700
Subject: iMX6Q - PCIe
In-Reply-To: <20140724095410.1b9bb401@e6520eb>
References: <CACUGKYP9w+qUUtp2LRKgD-Dz+2pubFeX82dGQ6tiv2Ji6VgVig@mail.gmail.com>
 <20140724001622.2b475138@e6520eb>
 <CACUGKYMpgN6PY5hrzNuM3KbT2+ZZtZ8M3es8QkXLxMD_hVcEAQ@mail.gmail.com>
 <20140724095410.1b9bb401@e6520eb>
Message-ID: <CACUGKYONXE+8Avuzr5yHaqsKk0TBQ9vH9uoU-BZdBUhA76F6vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

Thanks for the info.

I tested 3 PCIe modules and one of them got working properly on kernel
3.15.2 and the fsl kernel 3.10.17.


Regards,

john


On Thu, Jul 24, 2014 at 12:54 AM, Eric B?nard <eric@eukrea.com> wrote:
> Hi John,
>
> Le Wed, 23 Jul 2014 15:44:47 -0700,
> John Tobias <john.tobias.ph@gmail.com> a ?crit :
>> I have a few questions:
>>
>> 1. May I know what FSL's kernel version you are using?.
> was 3.0.35 + backport from 3.14 for 802.11 + ath9k from
> http://drvbp1.linux-foundation.org/~mcgrof/rel-html/backports/
>
>> 2. Did you make changes in your device tree for PCIe?.
> no DT on this kernel
>
>> 3. Can I have the model/part # of your ath9k?.
> tested with Mikrotik R11E & Ubiquiti SR71
>
> Eric

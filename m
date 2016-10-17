From: mw@semihalf.com (Marcin Wojtas)
Date: Mon, 17 Oct 2016 15:03:00 +0200
Subject: [PATCH v4 0/1] Armada 7k/8k CP110 system controller fixes
In-Reply-To: <CAPv3WKf13FJxGkpt+OcNO--hRQoZr-TtuzCcAJrQwFXjqRgM2Q@mail.gmail.com>
References: <1474789673-3837-1-git-send-email-mw@semihalf.com>
 <CAPv3WKf13FJxGkpt+OcNO--hRQoZr-TtuzCcAJrQwFXjqRgM2Q@mail.gmail.com>
Message-ID: <CAPv3WKdhe+3_2wjSwKD3i0OY5W3aPiaZAnAaidanyAzvvH6d6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Since merge window is closed, I kindly remind about remaining patch.

Best regards,
Marcin

2016-10-06 21:24 GMT+02:00 Marcin Wojtas <mw@semihalf.com>:
> Hi Stephen,
>
> Do you have any further comments on the remaining patch?
>
> Best regards,
> Marcin
>
> 2016-09-25 9:47 GMT+02:00 Marcin Wojtas <mw@semihalf.com>:
>> Hi,
>>
>> Two patches from the third version of the patchset have already been
>> applied, so I re-send the last one with corrected allocation of
>> clock data, which was pointed in the review.
>>
>> Any feedback would be very welcome.
>>
>> Best regards,
>> Marcin
>>
>> Changelog:
>> v4 <- v3
>> * fix allocation of clock data
>>
>> v3 <- v2
>> * return -ENOMEM on alloc failures
>>
>> v1 <- v2
>> * replace setting CLK_IS_BASIC flag with clearing init structure fields
>>   with memset
>> * minor improvements of allocation and error checking
>> * add migration to clk_hw
>>
>>
>> Marcin Wojtas (1):
>>   clk: mvebu: migrate CP110 system controller to clk_hw API and
>>     registration
>>
>>  drivers/clk/mvebu/cp110-system-controller.c | 150 +++++++++++++---------------
>>  1 file changed, 72 insertions(+), 78 deletions(-)
>>
>> --
>> 1.8.3.1
>>

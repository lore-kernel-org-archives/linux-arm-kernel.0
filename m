From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 2 Jul 2018 09:28:47 +0200
Subject: [PATCH v4 09/18] ARM: davinci: da850-evm: remove dead MTD code
In-Reply-To: <46acbc64-6d22-d361-941c-f67aa3029242@lechnology.com>
References: <20180629094039.7543-1-brgl@bgdev.pl>
 <20180629094039.7543-10-brgl@bgdev.pl>
 <46acbc64-6d22-d361-941c-f67aa3029242@lechnology.com>
Message-ID: <CAMpxmJW2L+nYoPgR0G63uML_bqrhVRwpNRDFEv2e=3r4Yd9NBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-06-29 19:09 GMT+02:00 David Lechner <david@lechnology.com>:
> On 06/29/2018 04:40 AM, Bartosz Golaszewski wrote:
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> We no longer need to register the MTD notifier to read the MAC address
>> as it's now being done in the emac address.
>
>
> I think you mean "it's now being done in the emac _driver_"

Haha yes I do. :)

Thanks,
Bart

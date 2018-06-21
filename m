From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Thu, 21 Jun 2018 13:41:26 +0200
Subject: [PATCH v7 0/4] ARM: davinci: complete the conversion to using the
 reset framework
In-Reply-To: <9ec10627-49a5-07ad-8c9d-5ac873096cc0@ti.com>
References: <20180621073706.22812-1-brgl@bgdev.pl>
 <9ec10627-49a5-07ad-8c9d-5ac873096cc0@ti.com>
Message-ID: <CAMRc=Me1JTuw40tMWaai2oKMxmc_ktN2OKBhF8tmGt0cQ6magg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-06-21 12:52 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
> Hi Bartosz,
>
> On Thursday 21 June 2018 01:07 PM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> These are the remaining patches that still need to be merged in order
>> to complete the conversion of the davinci dsp driver to using the reset
>> framework.
>>
>> They apply on top of v4.18-rc1 with David Lechner's remaining patches
>> merged.
>
> Series looks good to me.
>
> To preserve bisect, shouldn't the order of applying be patch #3, #4, #1
> and #2 ?
>
> Given the dependencies and to preserve bisect its easiest if I take the
> series with acks from remoteproc and clock maintainers.
>
> Open to other suggestions as well.
>
> Thanks,
> Sekhar

Oops you're right about the order. Do you want me to resend?

Bart

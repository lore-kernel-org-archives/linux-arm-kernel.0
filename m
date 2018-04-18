From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 18 Apr 2018 10:56:30 +0200
Subject: [PATCH v6 6/7] remoteproc/davinci: use the reset framework
In-Reply-To: <14b8384d-707d-42b7-b3ac-1ad914997a2e@ti.com>
References: <20180417173038.25510-1-brgl@bgdev.pl>
 <20180417173038.25510-7-brgl@bgdev.pl>
 <14b8384d-707d-42b7-b3ac-1ad914997a2e@ti.com>
Message-ID: <CAMRc=Mfj=M2a8Dw1SCzc4DBG6B+B8gbkr9DKaaSKiEs9hN6Bag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-04-18 7:44 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
> On Tuesday 17 April 2018 11:00 PM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Switch to using the reset framework instead of handcoded reset routines
>> we used so far.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Looks good!
>
> Reviewed-by: Sekhar Nori <nsekhar@ti.com>
>
> This depends on DaVinci gaining common clock / reset framework support
> though. I am guessing remoteproc maintainers will have to be reminded
> when its safe to apply.
>
> Thanks,
> Sekhar

Right, I assume you plan to apply the platform & DT patches from David
for 4.18? We can then provide an immutable branch to remoteproc
maintainers.

Bart

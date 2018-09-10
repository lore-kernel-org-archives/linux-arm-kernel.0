From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Mon, 10 Sep 2018 10:24:04 +0200
Subject: [PATCH v2 00/16] nvmem: rework of the subsystem for non-DT users
In-Reply-To: <da9556fd-0022-8e6a-12b4-cc3babbae5b0@linaro.org>
References: <20180907100750.14564-1-brgl@bgdev.pl>
 <da9556fd-0022-8e6a-12b4-cc3babbae5b0@linaro.org>
Message-ID: <CAMRc=MeT7UP57x+Q-a1ODRCvcGKKj_NSfkBLVQ9O5dhTC1DAYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-09-10 9:54 GMT+02:00 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>:
>
>
> On 07/09/18 11:07, Bartosz Golaszewski wrote:
>>
>> Next three patches improve the framework by adding a notifier chain
>> for future use and fixing the issue with nvmem device names.
>>
>> Finally we add support for cell definitions, cell lookups and make
>> DT systems resolve the nvmem cells during provider's registration.
>>
>> Last patches just use the SPDX license identifiers and make the
>> naming convention for some arguments more consistent.
>
> Please send separate series for fixes and things that do not depend on this
> new apis or Order/place them at the end of the series.
>

The API changes change so many things, that these series would be
incompatible. I can send the series separately but they would be
co-dependent anyway. Does it sound good?

Bart

> This can help reviewer when there is large number of patches in series with
> unrelated subject.
>
> -s-rini
>
>

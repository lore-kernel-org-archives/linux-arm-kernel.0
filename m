From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 10 Sep 2018 10:50:58 +0100
Subject: [PATCH v2 13/16] nvmem: add support for cell lookups from machine
 code
In-Reply-To: <CAMRc=Me0bYjdmaqqxKqFkRRSNdoOgDf1A==dASz0dJAtx9BDqg@mail.gmail.com>
References: <20180907100750.14564-1-brgl@bgdev.pl>
 <20180907100750.14564-14-brgl@bgdev.pl>
 <484b6ec5-cd8e-e5c5-0c5c-2f11c504ea1c@linaro.org>
 <CAMRc=MdnSHY1ah4X3Bu55HvZcOQHxPHaFudidDA4mEOW9ZzeEg@mail.gmail.com>
 <20180910102324.52ecd8f7@bbrezillon>
 <c72866dd-1fb0-c765-5815-ba63d051a09b@linaro.org>
 <CAMRc=Me0bYjdmaqqxKqFkRRSNdoOgDf1A==dASz0dJAtx9BDqg@mail.gmail.com>
Message-ID: <f161f5fd-a651-eee1-78ee-63607021db7f@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/09/18 10:45, Bartosz Golaszewski wrote:
>> Yes, this is how it should be!
>>
> Any actual reason for not putting these definitions into a separate
> 'machine' header? This approach is currently used by gpio, pinctrl,
> iio and regulator framework because most systems use either DT or ACPI
> and don't need to pull in any stuff aimed at board files.

I don't want to create header files specific to usecase!
Lets keep it simple!

--srini

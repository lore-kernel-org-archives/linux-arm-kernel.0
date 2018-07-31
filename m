From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 31 Jul 2018 15:34:33 +0530
Subject: [PATCH v7 1/4] remoteproc/davinci: use the reset framework
In-Reply-To: <CAMRc=MdwCruRZ_EQ3Pzq-=HdhiA6pfSZczRKMa5i9Rju0JgHig@mail.gmail.com>
References: <20180621073706.22812-1-brgl@bgdev.pl>
 <20180621073706.22812-2-brgl@bgdev.pl> <20180731042539.GE5090@builder>
 <CAMRc=MdwCruRZ_EQ3Pzq-=HdhiA6pfSZczRKMa5i9Rju0JgHig@mail.gmail.com>
Message-ID: <c3484965-1efe-2425-86e0-ecb78ea189dd@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bjorn,

On Tuesday 31 July 2018 01:25 PM, Bartosz Golaszewski wrote:
> 2018-07-31 6:25 GMT+02:00 Bjorn Andersson <bjorn.andersson@linaro.org>:
>> On Thu 21 Jun 00:37 PDT 2018, Bartosz Golaszewski wrote:
>>
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> Switch to using the reset framework instead of handcoded reset routines
>>> we used so far.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>> Reviewed-by: Sekhar Nori <nsekhar@ti.com>
>>> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
>>
>> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>
> 
> Sekhar,
> 
> can you take this through your tree or is it already too late?

The last -rc is already tagged and I am not sure ARM-SoC will be open to
new stuff now (there is also a bit of lag after I send my pull request).

Is this something you can take in your tree along with Suman's patch?

There are no build dependencies with my tree, so it will be safe to
queue from your tree. It will be great if this can be merged late in the
cycle though to avoid breaking remoteproc even for short while during
the merge window.

Or if you okay with it, it will be safest to send it soon after
v4.19-rc1 is tagged.

Let me know.

Thanks,
Sekhar

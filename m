From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 22 Nov 2016 11:57:38 +0100
Subject: [PATCH 1/3] of: base: add support to get machine compatible string
In-Reply-To: <5ce9fb9f-459a-562b-2e9f-85d35f9ec035@arm.com>
References: <1479811311-3080-1-git-send-email-bgolaszewski@baylibre.com>
 <1479811311-3080-2-git-send-email-bgolaszewski@baylibre.com>
 <5ce9fb9f-459a-562b-2e9f-85d35f9ec035@arm.com>
Message-ID: <CAMpxmJU=wR4mdQr5tpNSv8POirtWXR=_s7D_Q_H=Cuy=W=-Jtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-11-22 11:53 GMT+01:00 Sudeep Holla <sudeep.holla@arm.com>:
>
>
> On 22/11/16 10:41, Bartosz Golaszewski wrote:
>>
>> Add a function allowing to retrieve the compatible string of the root
>> node of the device tree.
>>
>
> Rob has queued [1] and it's in -next today. You can reuse that if you
> are planning to target this for v4.11 or just use open coding in your
> driver for v4.10 and target this move for v4.11 to avoid cross tree
> dependencies as I already mentioned in your previous thread.
>
> --
> Regards,
> Sudeep
>
> [1] http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1274549.html

Rob's patch checks the model first - I'm not sure this is the behavior
we want here as Sekhar suggested we print the machine compatible.

Thanks,
Bartosz Golaszewski

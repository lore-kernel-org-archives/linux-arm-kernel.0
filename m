From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 21 Feb 2017 10:19:12 +0530
Subject: [PATCH 2/4] ARM: dts: da850: add vpif video display pins
In-Reply-To: <CAMpxmJXjRYG5tteGNbG3gxAqeoB9Qx9bND6PHJih7dyU+ZuD4w@mail.gmail.com>
References: <1487268932-6469-1-git-send-email-bgolaszewski@baylibre.com>
 <1487268932-6469-3-git-send-email-bgolaszewski@baylibre.com>
 <318d9f87-ad2a-c0e1-255a-097056c0f85f@ti.com>
 <CAMpxmJXjRYG5tteGNbG3gxAqeoB9Qx9bND6PHJih7dyU+ZuD4w@mail.gmail.com>
Message-ID: <e6988d47-00e1-e4b6-e343-1f358faa5556@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 February 2017 09:12 PM, Bartosz Golaszewski wrote:
> 2017-02-20 11:29 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
>> On Thursday 16 February 2017 11:45 PM, Bartosz Golaszewski wrote:
>>> Add a new pinctrl sub-node for vpif display pins. Move VP_CLKIN3 and
>>> VP_CLKIN2 to the display node where they actually belong (vide section
>>> 35.2.2 of the da850 datasheet).
>>
>> You mean 36.2.2. Also, its in the technical reference manual (TRM). The
>> datahseet is another document.
>>
> 
> I'm looking at the revision from September 2016 and it's 35.2.2: VPIF
> -> Architecture -> signal descriptions.

Is this the document ?

http://www.ti.com/lit/ug/spruh77c/spruh77c.pdf

In this VPIF is chapter 36.

Thanks,
Sekhar

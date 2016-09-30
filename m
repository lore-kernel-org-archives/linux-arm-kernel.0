From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 30 Sep 2016 17:17:32 +0530
Subject: [PATCH 4/6] ARM: dts: da850-lcdk: add support for 1024x768
 resolution
In-Reply-To: <CAMpxmJVA+p1st7HzwoOJftArqpY-wUQb8WKbQFAEWnBOysxF6w@mail.gmail.com>
References: <1475166715-7857-1-git-send-email-bgolaszewski@baylibre.com>
 <1475166715-7857-5-git-send-email-bgolaszewski@baylibre.com>
 <20160929185805.q2pdihajikgzo4lm@gobelin>
 <CAMpxmJVA+p1st7HzwoOJftArqpY-wUQb8WKbQFAEWnBOysxF6w@mail.gmail.com>
Message-ID: <2ae49789-1857-8a74-401e-6f1d27c71fae@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 30 September 2016 03:07 PM, Bartosz Golaszewski wrote:
> 2016-09-29 20:58 GMT+02:00 Karl Beldan <karl.beldan@gmail.com>:
>> Hi,
>>
>> On Thu, Sep 29, 2016 at 06:31:53PM +0200, Bartosz Golaszewski wrote:
>>> Add svga timings for 1024x768 resolution to the da850-lcdk
>>> device tree.
>>>
>>
> 
> [snip]
> 
>>
>> Why do you also call 1024x768 svga ?
>>
> 
> Thanks, should have been xga. will fix in v2.

When you send the v2, can you please include the driver folks too. I am
no expert on DRM and LCDC and would like to ensure they had a look at
the dts patches too.

Thanks,
Sekhar

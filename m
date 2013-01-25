From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Jan 2013 10:49:43 +0100
Subject: [PATCH 00/10] rework gpio pxa driver for pinctrl
In-Reply-To: <20130123131503.GJ2239@intel.com>
References: <1358929554-32265-1-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdZ+COLEbMyHFDEaEVj21UU29q-Qg=3bk3==9QcS+UCJEA@mail.gmail.com>
 <20130123131503.GJ2239@intel.com>
Message-ID: <CACRpkdZz56d8VH9DmH_OiAmTMOKE_-w-kmCTYLFaUhvHj=z1SQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 2:15 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Wed, Jan 23, 2013 at 01:27:23PM +0100, Linus Walleij wrote:
>> On Wed, Jan 23, 2013 at 9:25 AM, Haojian Zhuang
>> <haojian.zhuang@linaro.org> wrote:
>>
>> > Remove all cpu depend macro. Bind gpio pxa driver with pinctrl driver.
>>
>> Please route this patch series by Mika so he can test it on his
>> funny hardware too.
>
> The hardware we have is Intel Lynxpoint (a PCH chipset for Haswell which
> has x86 core). The only PXA based IP block it has is the SPI controller as
> far as I know. For GPIOs we have Intel own GPIO block, which is different
> than the PXA one (at least I think so, adding Mathias just in case).
>
> Not sure how it helps if I test this series on Lynxpoint :-)

Heheh sorry Mika there is too much PXA stuff happening right
now :-)

I admit I confused the GPIO for the SPI. I'll just go and apply
Haoijan's patches.

Yours,
Linus Walleij

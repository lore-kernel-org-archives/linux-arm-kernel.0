From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sun, 10 Feb 2013 01:17:23 +0800
Subject: [PATCH v7 0/15] support pinconf in pinctrl single driver
In-Reply-To: <20130209134157.081B63E30EC@localhost>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
 <20130209134157.081B63E30EC@localhost>
Message-ID: <CAD6h2NRoHMLJooqLba9uFJO6sMaxfTh_fOHgzOVXnoRK4ja=YA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 February 2013 21:41, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Fri, 18 Jan 2013 15:31:04 +0800, Haojian Zhuang <haojian.zhuang@linaro.org> wrote:
>> Changelog:
>> v7:
>> 1. Discard the method of adding gpio range from pinctrl-single driver.
>> Use gpiolib driver to support gpio range from DTS instead.
>> 2. Add gpio request function to claim pin in gpio pl061 driver.
>> 3. Adjust the initcall level in gpio pl061 driver.
>> 4. Allocate gpio number from lowest gpio number to highest. The original
>> implementation is inverted. It's hard to use since it inverted the sequence
>> of gpio number.
>> 5. Remove the support of pxa910 temporarily since gpio pxa driver need to
>> be updated for supporting this solution
>
> Linus, I'll let you make decisions on this patch series since it is
> mostly pinctrl related.
>
> g.

Since Tony has some opinions on pinctrl, I'll update them and send the v8
patches right now.

Thanks
Haojian

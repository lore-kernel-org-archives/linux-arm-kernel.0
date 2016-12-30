From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 Dec 2016 10:23:05 +0100
Subject: [PATCH 7/9] pinctrl: samsung: Add property to mark pad state as
 suitable for power down
In-Reply-To: <20161227153331.jbh7ei6oh3obmnri@kozik-lap>
References: <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161223122538epcas5p29515ceff21963ab035b3b32878830ce2@epcas5p2.samsung.com>
 <1482495889-6201-8-git-send-email-m.szyprowski@samsung.com>
 <20161225191914.5bzl6fso36ozuum6@kozik-lap>
 <bd48fe32-5296-fc23-dbb8-d212292d76cd@samsung.com>
 <20161227153331.jbh7ei6oh3obmnri@kozik-lap>
Message-ID: <CACRpkdYzGjxyePcc-WiWDoX9rF6mP+mqCtk=zBUGb0-DvAjxvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 27, 2016 at 4:33 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Tue, Dec 27, 2016 at 11:30:57AM +0100, Marek Szyprowski wrote:

>> Separate sleep state is needed because of the pin control bindings and
>> design.
>>
>> A separate sleep state is required to let pin control client driver (in this
>> case
>> Exynos I2S driver) let to choose when it is okay to switch pads into sleep
>> state and I see no other way to achieve this.
>
> Maybe the pinctrl API should be extended for this? Doing this in DTS
> just for purpose of passing information between drivers (consumer and
> provider) looks odd.

I don't understand what is going on but you are all smart people so I
guess you're right :)

Tell me if I can help clarifying something...

Yours,
Linus Walleij

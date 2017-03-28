From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 28 Mar 2017 11:38:20 +0200
Subject: [RFT PATCH 5/6] pinctrl: meson: use gpio-ranges from DT
In-Reply-To: <CACRpkdZqfwKZ=2SQzr_D5-M5em+7JBS7eUaJ_VH33uV5AZ8xRw@mail.gmail.com>
References: <1490286449-19448-1-git-send-email-narmstrong@baylibre.com>
 <1490286449-19448-6-git-send-email-narmstrong@baylibre.com>
 <CACRpkdZqfwKZ=2SQzr_D5-M5em+7JBS7eUaJ_VH33uV5AZ8xRw@mail.gmail.com>
Message-ID: <c575d8e4-05ca-8eb0-8b64-24a65a5711a7@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2017 11:30 AM, Linus Walleij wrote:
> On Thu, Mar 23, 2017 at 5:27 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> 
> '> When trying to add a gpio-hog, we enter a weird loop where the gpio-ranges
>> is needed when gpiochip_add_data() is called but in the current implementation
>> the ranges are added from the driver afterwards.
>>
>> A simple solution is to rely on the DR gpio-ranges attribute and remove the
>> call to gpiochip_add_pin_range().
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> This is fine once the ranges have been applied to the device trees I guess.
> 
> Tell me when you want me to merge this.
> 
> Yours,
> Linus Walleij
> 

Hi Linus,

Kevin should merge the DT patches since they have now Tested and Reviewed by's, so you can merge it now if you can.
Since it will live in you pinctrl tree, it will only impact linux-next until Kevin merges them.

Thanks,
Neil

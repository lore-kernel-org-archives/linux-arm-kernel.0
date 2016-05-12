From: patrice.chotard@st.com (Patrice Chotard)
Date: Thu, 12 May 2016 16:47:22 +0200
Subject: [PATCH] pinctrl: stm32: Implement .pin_config_dbg_show()
In-Reply-To: <CACRpkdawoqfqN8YeojyrzPru2fwrFMidc1e2v7yxHRpPf+rK6w@mail.gmail.com>
References: <1461939943-24752-1-git-send-email-patrice.chotard@st.com>
 <CACRpkdZ=KsPL1mBS1bLi=jYsv=Vb1QNBi8XPAJW50doPcwBuZg@mail.gmail.com>
 <5733364A.3090606@st.com>
 <CACRpkdawoqfqN8YeojyrzPru2fwrFMidc1e2v7yxHRpPf+rK6w@mail.gmail.com>
Message-ID: <5734977A.1090409@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/12/2016 03:40 PM, Linus Walleij wrote:
> On Wed, May 11, 2016 at 3:40 PM, Patrice Chotard <patrice.chotard@st.com> wrote:
>> On 05/10/2016 01:50 PM, Linus Walleij wrote:
>> Sorry i didn't pay attention, but there is a compilation warning in this
>> patch.
>>
>> drivers/pinctrl/stm32/pinctrl-stm32.c:823:7: warning: too many arguments for
>> format [-Wformat-extra-args]
>>         speeds[speed], "speed");
>>
>>
>> What do you prefer ?
>>   _ me to submit a v2 fixing this warning and at the same occasion include
>> the requested code factorization
>>   _ or submit additionnal patchset ?
> Just send a patch on top fixing this.

Series just send

Thanks
Patrice

>
> Yours,
> Linus Walleij

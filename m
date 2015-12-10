From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Dec 2015 17:50:24 +0100
Subject: [PATCH 2/3] pinctrl: nsp: add pinmux driver support for Broadcom
 NSP SoC
In-Reply-To: <565C81E4.90507@broadcom.com>
References: <1448042245-25702-1-git-send-email-yrdreddy@broadcom.com>
 <CACRpkdZ=vyPSiPCUppfDWC9OShqfe-BRvB5QjU1AZmbDbYvsZQ@mail.gmail.com>
 <565C81E4.90507@broadcom.com>
Message-ID: <CACRpkdaytru_AOK4p9Si9fJs6=DKgrqJ6HV4-To_a8Q+R+40jA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 6:05 PM, Ray Jui <rjui@broadcom.com> wrote:
> Hi Linus,
>
> On 11/30/2015 4:49 AM, Linus Walleij wrote:
>>
>> On Fri, Nov 20, 2015 at 6:57 PM, Yendapally Reddy Dhananjaya Reddy
>> <yrdreddy@broadcom.com> wrote:
>>
>>> This adds the initial support of the Broadcom NSP pinmux driver.
>>>
>>> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yrdreddy@broadcom.com>
>>
>>
>> So what does Ray and Stephen say about this?
>>
>> Is the hardware unique enough to warrant its own driver?
>>
>> Or should it utilize/extend one of the existing Broadcom
>> drivers?
>
>
> Currently, the IOMUX configurations in Cygnus, NSP, and NS2 are completely
> different and require a separate driver to each of these SoCs. We now
> realize the shortcomings and have been communicating with our ASIC team.
> We'd like to fix this for the next-gen of our SoC. We are driving towards
> using a register layout that will allow us to use just "pinctrl-single" and
> "pinconf-single."

OK can you provide your reviews for the NSP driver?

Yours,
Linus Walleij

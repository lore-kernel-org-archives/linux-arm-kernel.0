From: rjui@broadcom.com (Ray Jui)
Date: Mon, 30 Nov 2015 09:05:40 -0800
Subject: [PATCH 2/3] pinctrl: nsp: add pinmux driver support for Broadcom
 NSP SoC
In-Reply-To: <CACRpkdZ=vyPSiPCUppfDWC9OShqfe-BRvB5QjU1AZmbDbYvsZQ@mail.gmail.com>
References: <1448042245-25702-1-git-send-email-yrdreddy@broadcom.com>
 <CACRpkdZ=vyPSiPCUppfDWC9OShqfe-BRvB5QjU1AZmbDbYvsZQ@mail.gmail.com>
Message-ID: <565C81E4.90507@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 11/30/2015 4:49 AM, Linus Walleij wrote:
> On Fri, Nov 20, 2015 at 6:57 PM, Yendapally Reddy Dhananjaya Reddy
> <yrdreddy@broadcom.com> wrote:
>
>> This adds the initial support of the Broadcom NSP pinmux driver.
>>
>> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yrdreddy@broadcom.com>
>
> So what does Ray and Stephen say about this?
>
> Is the hardware unique enough to warrant its own driver?
>
> Or should it utilize/extend one of the existing Broadcom
> drivers?

Currently, the IOMUX configurations in Cygnus, NSP, and NS2 are 
completely different and require a separate driver to each of these 
SoCs. We now realize the shortcomings and have been communicating with 
our ASIC team. We'd like to fix this for the next-gen of our SoC. We are 
driving towards using a register layout that will allow us to use just 
"pinctrl-single" and "pinconf-single."

>
> Yours,
> Linus Walleij
>

Thanks,

Ray

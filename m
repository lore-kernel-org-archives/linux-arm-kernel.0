From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Mon, 26 Nov 2012 17:33:39 +0530
Subject: [PATCH RFC] i2c: omap: Remove the OMAP_I2C_IP_VERSION_*
In-Reply-To: <20121126115208.GA17605@arwen.pp.htv.fi>
References: <1353929982-13984-1-git-send-email-shubhrajyoti@ti.com>
 <20121126115208.GA17605@arwen.pp.htv.fi>
Message-ID: <CAM=Q2cvU9zH49qrRPJVxwn80DiuBC2NeBOCpoV3JYMJ3e9Eu0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 5:22 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Mon, Nov 26, 2012 at 05:09:42PM +0530, Shubhrajyoti D wrote:
>> The OMAP_I2C_IP_VERSION_1 and OMAP_I2C_IP_VERSION_2 was needed
>> as on VER2 we were not reading all the 32-bits. Since now that
>> we read the hi register we do not need the OMAP_I2C_IP_VERSION_*.
>> Delete the same.
>>
>> The custom reset is also changed to detect VER2 based on the
>> scheme.
>
> looks like this should become a series IMO.
>
> First patch would move the macros to common header, second patch would
> switch the Reset part to use those macros and third patch gets rid of
> OMAP_I2C_IP_VERSION_*
>
> other than that, looks very good to me.

OK will respin it accordingly.

>
> --
> balbi

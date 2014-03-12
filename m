From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 12 Mar 2014 17:30:52 -0300
Subject: [PATCHv14][ 4/4] ARM: dts: imx25: mbimxsd25: Add displays support.
In-Reply-To: <CAOMZO5Dux0Cq9desLAotznLa0=kznFPyPvAHKtida6y3gC6SQQ@mail.gmail.com>
References: <1390410577-22073-1-git-send-email-denis@eukrea.com>
 <1390410577-22073-4-git-send-email-denis@eukrea.com>
 <CAOMZO5AHdTbCQUPGjQaK0v6KJR3+fTN9Pb1sqaYwuKXgfK5U5g@mail.gmail.com>
 <20140312184048.4b6dbb21@e6520eb>
 <CAOMZO5Dux0Cq9desLAotznLa0=kznFPyPvAHKtida6y3gC6SQQ@mail.gmail.com>
Message-ID: <CAOMZO5Adu=5ymDeYeYU8vCLkR--G2H8s6KJ14RmQs3q4ctzmqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Denis/Eric,

On Wed, Mar 12, 2014 at 3:24 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Eric,
>
> On Wed, Mar 12, 2014 at 2:40 PM, Eric B?nard <eric@eukrea.com> wrote:
>> Hi Fabio,
>>
>> Le Wed, 12 Mar 2014 14:27:25 -0300,
>> Fabio Estevam <festevam@gmail.com> a ?crit :
>>> Any ideas?
>>>
>> do you drive the signal LCD_EN GPIO3_17 ?
>
> Good point. Even though I am not touching LCD_EN it is at the correct
> level of 0.
>
> I get 3.3V at LCD_VCC and VDD_LCDIO. 5V is present at LCD_5V that
> drives the backlight.
>
> So the LCD supplies seem to be good.
>
> The problem should be in some other area.

Do you know of a kernel version where imxfb is functional?

I have tried latest linus tree and booted a non-dt kernel on mx25pdk
and I get the same white display.

Regards,

Fabio Estevam

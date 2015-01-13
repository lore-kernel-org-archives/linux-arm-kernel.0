From: cooloney@gmail.com (Bryan Wu)
Date: Tue, 13 Jan 2015 11:18:30 -0800
Subject: [PATCHv2 2/2] leds: tlc59116: Driver for the TI 16 Channel i2c
 LED driver
In-Reply-To: <20150113191349.GE14570@lunn.ch>
References: <1420843545-30892-1-git-send-email-andrew@lunn.ch>
 <1420843545-30892-3-git-send-email-andrew@lunn.ch>
 <CAK5ve-JQJJH_Dk=+PbFyRL3cjQUU4a5au4h9Kfcz6L6_iAfPKA@mail.gmail.com>
 <20150113191349.GE14570@lunn.ch>
Message-ID: <CAK5ve-LS0KO4avfprz=6rS4MT5AdiAtF02EVvv=cRbz03t4E_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 11:13 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Tue, Jan 13, 2015 at 10:55:23AM -0800, Bryan Wu wrote:
>> On Fri, Jan 9, 2015 at 2:45 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> > The TLC59116 is an I2C bus controlled 16-channel LED driver.  Each LED
>> > output has its own 8-bit fixed-frequency PWM controller to control the
>> > brightness of the LED.
>> >
>> > This is based on a driver from Belkin, but has been extensively
>> > rewritten.
>> >
>> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
>> > Cc: Matthew.Fatheree at belkin.com
>>
>> Looks good, applied to my tree.
>
> Great, thanks.
>
> Will you also take the device tree binding document patch?
>
> Thanks
>         Andrew

Can you update that one without that gpio thing in the example? And if
there is no objection from others, I will take it.

-Bryan

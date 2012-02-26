From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Sun, 26 Feb 2012 11:59:43 +0100
Subject: [PATCH] pxa/hx4700: Set DS1WM clock_rate
In-Reply-To: <1312970654.10843.YahooMailClassic@web29012.mail.ird.yahoo.com>
References: <CAMPhdO_xL_sUui-22p27oAw52YHnBhm90cn12t5eJsdRLnUfNA@mail.gmail.com>
 <1312970654.10843.YahooMailClassic@web29012.mail.ird.yahoo.com>
Message-ID: <CA+gwMcdPno_ZhjJ=8ioLBqG6bOv7ZaAf19EtfzQt9zWgYas+Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 12:04 PM, Paul Parsons <lost.distance@yahoo.com> wrote:
> Hi Eric,
>
>> Or this parent driver can silently pass the clock_rate to
>> ds1wm sub-driver
>> without the if () condition, as it leaves to the sub-driver
>> to decide whether
>> it's a valid value, unless you want to use 'clock_rate' to
>> explicitly control
>> the registration of the sub-device.
>
> I followed the example of the pxa/magician + mfd/htc-pasic3 platform.

For PASIC3 there is a PASIC2 variant that doesn't include the DS1WM.
I'm not sure if there are ASIC3 devices that don't use the integrated
DS1WM, so this might not be needed in this case.
Either way,
Acked-by: Philipp Zabel <philipp.zabel@gmail.com>

regards
Philipp

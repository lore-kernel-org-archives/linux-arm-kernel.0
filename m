From: leigh@solinno.co.uk (Leigh Brown)
Date: Wed, 25 Mar 2015 23:00:11 +0000
Subject: [PATCH] ARM: mvebu: GPIO reset on GlobalScale Mirabox
In-Reply-To: <551333D2.8080600@free-electrons.com>
References: <1427319230-2500-1-git-send-email-leigh@solinno.co.uk>
 <551333D2.8080600@free-electrons.com>
Message-ID: <8c59bb2d9802adfc70116df08b61fda1@doppler.thel33t.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On 2015-03-25 22:16, Gregory CLEMENT wrote:
> On 25/03/2015 22:33, Leigh Brown wrote:
>> Add support for the system reset button on the GlobalScale Mirabox.
>> The reset button is connected via GPIO so add a gpio-keys entry for
>> it in the device tree file.  Patch is based on the implementation
>> in armada-370-netgear-rn102.dts but using the GPIO pin specified in
>> the original patch by Ezequiel Garcia from 2013.
> 
> Thanks for your contribution, however the reset button is not always
> connected to this GPIO. At least on the Mirabox I have the reset button
> triggers an hardware reset. My concern is that for some board the dts
> representation would be wrong.

I wish I had your Mirabox, because having the reset button on a GPIO is
almost useless :-(

However, I have what I have so it would be nice to find a way to support
it.

Regards,

Leigh.

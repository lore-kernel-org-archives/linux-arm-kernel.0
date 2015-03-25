From: leigh@solinno.co.uk (Leigh Brown)
Date: Wed, 25 Mar 2015 23:16:24 +0000
Subject: [PATCH] ARM: mvebu: GPIO reset on GlobalScale Mirabox
In-Reply-To: <20150325223652.GC31858@lunn.ch>
References: <1427319230-2500-1-git-send-email-leigh@solinno.co.uk>
 <551333D2.8080600@free-electrons.com> <20150325223652.GC31858@lunn.ch>
Message-ID: <b4d74b2eae98b2b9d56a49536a8aa4ff@doppler.thel33t.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On 2015-03-25 22:36, Andrew Lunn wrote:
>> Thanks for your contribution, however the reset button is not always
>> connected to this GPIO. At least on the Mirabox I have the reset 
>> button
>> triggers an hardware reset. My concern is that for some board the dts
>> representation would be wrong.
> 
> When looking at WiFi issues, it became clear there are two different
> wifi designs. I would not be too surprised if this reset button
> changed at the same time.
> 
> Gregory, Leigh, is your wifi on the SDIO bus, or the USB bus?
> 
> The mirabox i have has an sdio wifi device. But i cannot easily test
> the reset button, i blew the 5v power rail, so all USB is dead, and my
> rootfs was on mmc, which is implemented via USB :-(

The WiFi on my Mirabox is on the SDIO bus.

[   29.408420] mwifiex_sdio mmc0:0001:1: WLAN FW already running! Skip 
FW dnld
[   29.408430] mwifiex_sdio mmc0:0001:1: WLAN FW is active
[   29.511297] mwifiex_sdio mmc0:0001:1: driver_version = mwifiex 1.0 
(14.66.35.p52)

Regards,

Leigh.

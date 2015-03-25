From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 26 Mar 2015 00:10:58 +0100
Subject: [PATCH] ARM: mvebu: GPIO reset on GlobalScale Mirabox
In-Reply-To: <b4d74b2eae98b2b9d56a49536a8aa4ff@doppler.thel33t.co.uk>
References: <1427319230-2500-1-git-send-email-leigh@solinno.co.uk>
 <551333D2.8080600@free-electrons.com> <20150325223652.GC31858@lunn.ch>
 <b4d74b2eae98b2b9d56a49536a8aa4ff@doppler.thel33t.co.uk>
Message-ID: <55134082.7010404@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 26/03/2015 00:16, Leigh Brown wrote:
> Hi Andrew,
> 
> On 2015-03-25 22:36, Andrew Lunn wrote:
>>> Thanks for your contribution, however the reset button is not always
>>> connected to this GPIO. At least on the Mirabox I have the reset 
>>> button
>>> triggers an hardware reset. My concern is that for some board the dts
>>> representation would be wrong.
>>
>> When looking at WiFi issues, it became clear there are two different
>> wifi designs. I would not be too surprised if this reset button
>> changed at the same time.
>>
>> Gregory, Leigh, is your wifi on the SDIO bus, or the USB bus?
>>
>> The mirabox i have has an sdio wifi device. But i cannot easily test
>> the reset button, i blew the 5v power rail, so all USB is dead, and my
>> rootfs was on mmc, which is implemented via USB :-(
> 
> The WiFi on my Mirabox is on the SDIO bus.
> 
> [   29.408420] mwifiex_sdio mmc0:0001:1: WLAN FW already running! Skip 
> FW dnld
> [   29.408430] mwifiex_sdio mmc0:0001:1: WLAN FW is active
> [   29.511297] mwifiex_sdio mmc0:0001:1: driver_version = mwifiex 1.0 
> (14.66.35.p52)

I think it is the same for me. I brought my Mirabox at ELC, but it is in
my room and just after ELC I will go to the airport. If I find a plug
there, I will boot it and I will confirm you, else we will have to wait
until Friday morning CET.


Thanks,

Gregory


> 
> Regards,
> 
> Leigh.
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

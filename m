From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri, 10 Nov 2017 09:05:59 +0800
Subject: [PATCH 1/1] add rgb888 pins to a20 to enable parallel rgb LCD
In-Reply-To: <20171108105623.zzabmqd3a3sehg2k@flea.lan>
References: <1510058999-6778-1-git-send-email-giulio.benetti@micronovasrl.com>
 <20171107130331.4wut5g6znzakkg4z@flea>
 <65694f1d-e1cb-08e0-0883-f0087f5e09f5@micronovasrl.com>
 <20171108105623.zzabmqd3a3sehg2k@flea.lan>
Message-ID: <a57155315f2d5791b629e03240265e2e@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-11-08 18:56?Maxime Ripard ???
> Hi,
> 
> On Tue, Nov 07, 2017 at 05:38:55PM +0100, Giulio Benetti wrote:
>> Board could be any with A20,
>> for example Olinuxino A20.
>> Or our Q027, S027 boards, but final dts still are not complete.
> 
> Therefore no upstream boards are using it right now, so we'll merge it
> when that will be the case.

I think the LCD connector on Banana Pi's uses parallel interface,
although the LCD should be an external DT overlay.

> 
> Maxime
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

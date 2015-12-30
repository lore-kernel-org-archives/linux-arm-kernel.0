From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Wed, 30 Dec 2015 17:07:46 +0100
Subject: [PATCH] ARM: dts: rockchip: Adding LEDs handling via leds-gpio
 for the Radxa Rock2 Square
In-Reply-To: <3020768.zersTrE99c@diego>
References: <1451474219-1313-1-git-send-email-romain.perier@gmail.com>
 <3613784.8JLtyMHEE9@diego> <1451490343.11453.28.camel@collabora.co.uk>
 <3020768.zersTrE99c@diego>
Message-ID: <1451491666.11453.29.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-12-30 at 16:53 +0100, Heiko St?bner wrote:
> Am Mittwoch, 30. Dezember 2015, 16:45:43 schrieb Sjoerd Simons:
> > On Wed, 2015-12-30 at 16:20 +0100, Heiko St?bner wrote:
> > >?
> I only looked at the schematics, so missed that. While personally I'd
> still?
> like having the "christmas-tree" off by default, Sjoerd's argument
> for the?
> trigger-choice sounds sensible.
> Hint for next time: Describing that makes a good commit message
> 
> Anybody opposed to me adding the following commit message?
> 
> ----
> Describe the two user-controllable LEDs on Rock2-square boards.
> The default-triggers mimic the behaviour of the vendor-kernel to
> keep functionalities in sync.
> ----

Looks good to me, with that commit message feel free to add:

Reviewed-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> 
> Heiko
> 

-- 
Sjoerd Simons
Collabora Ltd.

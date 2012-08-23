From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 23 Aug 2012 09:32:53 +0800
Subject: Can one  set GPIO direction in pinmux definition?
In-Reply-To: <503558B8.4010603@grid-net.com>
References: <5034FCB2.5040709@grid-net.com> <5035388D.2060909@wwwdotorg.org>
 <503558B8.4010603@grid-net.com>
Message-ID: <20120823013250.GY24242@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 03:10:00PM -0700, Subodh Nijsure wrote:
> Right now that is what I am doing in my code, requesting GPIOs in
> UART drivers and setting up the direction. I just wanted to make
> sure there wasn't way to setup pin direction using pinmux itself.
> 
No, there is no way for pinctrl driver to set up gpio direction, which
is completely gpio driver's job.

-- 
Regards,
Shawn

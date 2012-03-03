From: arnd.bergmann@linaro.org (Arnd Bergmann)
Date: Sat, 3 Mar 2012 02:09:51 +0000
Subject: [PATCH] Initial Device Tree system for Snowball
In-Reply-To: <1330703567-17925-1-git-send-email-niklas.hernaeus@stericsson.com>
References: <1330703567-17925-1-git-send-email-niklas.hernaeus@stericsson.com>
Message-ID: <201203030209.51767.arnd.bergmann@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 March 2012, Niklas Hernaeus wrote:
> 
> From: Niklas Hernaeus <niklas.hernaeus@linaro.org>
> 
> This is the base system for using Device Tree for Snowball.
> The new boardfile is a slightly modified copy of the original board file,
> so new Device Tree stuff can simply be added and code removed, while
> functionality stays the same.

I realized that this series is based on a version before Lee's patches
to add the soc information, and things have changed quite a bit with that.

I've played a bit more with this and tried to merge the two, the result
is a series in the testing/ux500/dt branch of arm-soc.git. I'm sure it's not
actually all correct, but I've tried my best there and also added quite
a bit of device tree source for illustration. Maybe the two of you can
have a look there and see what you can make of it.

	Arnd

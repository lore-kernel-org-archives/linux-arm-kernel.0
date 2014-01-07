From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 07 Jan 2014 13:54:55 +0100
Subject: [PATCH] ARM: cache-l2x0: Parse properties from DT for PL310 cache
 controller
In-Reply-To: <52CBF606.5080209@arm.com>
References: <1389094888-24348-1-git-send-email-tushar.behera@linaro.org>
 <52CBF606.5080209@arm.com>
Message-ID: <4325123.pn10H18tk9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 January 2014 12:41:42 Sudeep Holla wrote:
> Hi Tushar,
> 
> This has been discussed couple of times in past[1][2], and the opinion was not
> to have these in DT as they are more configuration data than the actual hardware
> description.

How do you suggest we get rid of the magic constants in platform code then?
I definitely don't want to keep the current state, and having configuration
data in DT seems the lesser evil.

Are there some reasonable defaults that Linux could use independent of the
platform and of what the boot loader defaults to?

	Arnd

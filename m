From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 8 Apr 2010 15:12:47 +0100
Subject: AC97 problems with pxa...
In-Reply-To: <4BBDE2BD.6000708@bitsim.com>
References: <4BBBACBE.7040505@bitsim.com>
	<201004070950.37809.marek.vasut@gmail.com>
	<4BBC5254.7040200@bitsim.com>
	<20100407095449.GA13576@rakim.wolfsonmicro.main>
	<4BBD9F28.9080804@bitsim.com>
	<20100408095415.GC6303@rakim.wolfsonmicro.main>
	<4BBDD480.8020708@bitsim.com>
	<20100408134946.GD30647@rakim.wolfsonmicro.main>
	<4BBDE2BD.6000708@bitsim.com>
Message-ID: <20100408141247.GE30647@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 08, 2010 at 04:05:49PM +0200, Jakob Viketoft wrote:

> The log output with kobject listed (do you need more info?)

> kobject: 'colibri270-v2-asoc' (c3c20bc0): kobject_add_internal:
> parent: 'drivers', set: 'drivers'
> kobject: 'colibri270-v2-asoc' (c3c20bc0): kobject_uevent_env
> kobject: 'colibri270-v2-asoc' (c3c20bc0): fill_kobj_path: path =
> '/bus/platform/drivers/colibri270-v2-asoc'
> ALSA device list:
>   No soundcards found.

So you've registered a driver for someting called 'collabri270-v2-asoc'
- what is that?  This doesn't seem to correspond to the code you
previously posted and there's no soc-audio anywhere here...

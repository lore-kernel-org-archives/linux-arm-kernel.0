From: gregkh@suse.de (Greg KH)
Date: Wed, 10 Aug 2011 08:02:32 -0700
Subject: [PATCH 4/4] Move top level platform devices in sysfs to
	/sys/devices/soc/X
In-Reply-To: <1312981422-13294-4-git-send-email-lee.jones@linaro.org>
References: <1312981422-13294-1-git-send-email-lee.jones@linaro.org>
	<1312981422-13294-4-git-send-email-lee.jones@linaro.org>
Message-ID: <20110810150232.GC7938@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 02:03:42PM +0100, Lee Jones wrote:
> At the request of Arnd Bergmann this patch moves all SoC
> platform devices found in sysfs from /sys/devices/platform to
> /sys/devices/soc/<SoCNum>/. It is believed as the devices are
> SoC specific and a /sys/devices/soc node has recently become
> available, that this would be a more appropriate place to
> display the data.

And what userspace tools did you just break by doing this?

greg k-h

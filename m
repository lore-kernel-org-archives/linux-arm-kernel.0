From: gregkh@suse.de (Greg KH)
Date: Thu, 1 Sep 2011 07:24:25 -0700
Subject: [PATCH 3/4] mach-ux500: export System-on-Chip information ux500
	via sysfs
In-Reply-To: <4E5F2D07.2060109@linaro.org>
References: <1312981422-13294-1-git-send-email-lee.jones@linaro.org>
	<1312981422-13294-3-git-send-email-lee.jones@linaro.org>
	<20110810150346.GE7938@suse.de> <4E5F2D07.2060109@linaro.org>
Message-ID: <20110901142425.GA5728@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 01, 2011 at 07:58:15AM +0100, Lee Jones wrote:
> On 10/08/11 16:03, Greg KH wrote:
> > On Wed, Aug 10, 2011 at 02:03:41PM +0100, Lee Jones wrote:
> >> Here we make use of the new drivers/base/soc driver to export
> >> vital SoC information out to userspace via sysfs. This patch
> >> provides a data structure of strings to populate the base
> >> nodes found in:
> >>
> >> /sys/devices/soc/[1|2|3|...]/[family|machine|revision|soc_id].
> >>
> >> It also adds one more node as requested by ST-Ericsson.
> > 
> > What is that node, and why was it requested and where is it documented?
> 
> I can answer the first two questions, but where would you like it
> documented? Is the commit message suitable, or would you like another
> Document text file created/appended to?

All user apis are documented in Documentation/ABI/, so files need to be
added there if you are adding/changing/deleting sysfs files.

thanks,

greg k-h

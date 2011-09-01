From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 01 Sep 2011 07:58:15 +0100
Subject: [PATCH 3/4] mach-ux500: export System-on-Chip information ux500
	via sysfs
In-Reply-To: <20110810150346.GE7938@suse.de>
References: <1312981422-13294-1-git-send-email-lee.jones@linaro.org>
	<1312981422-13294-3-git-send-email-lee.jones@linaro.org>
	<20110810150346.GE7938@suse.de>
Message-ID: <4E5F2D07.2060109@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/11 16:03, Greg KH wrote:
> On Wed, Aug 10, 2011 at 02:03:41PM +0100, Lee Jones wrote:
>> Here we make use of the new drivers/base/soc driver to export
>> vital SoC information out to userspace via sysfs. This patch
>> provides a data structure of strings to populate the base
>> nodes found in:
>>
>> /sys/devices/soc/[1|2|3|...]/[family|machine|revision|soc_id].
>>
>> It also adds one more node as requested by ST-Ericsson.
> 
> What is that node, and why was it requested and where is it documented?

I can answer the first two questions, but where would you like it
documented? Is the commit message suitable, or would you like another
Document text file created/appended to?

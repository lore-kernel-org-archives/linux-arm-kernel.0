From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Mon, 26 Apr 2010 10:26:51 +0900
Subject: [PATCH 0/8] Initial implementation of kdump for ARM
In-Reply-To: <20100423041106.GG3028@esdhcp04058.research.nokia.com>
References: <cover.1271752135.git.ext-mika.1.westerberg@nokia.com>
	<20100422120308.GD26418@gw.healthdatacare.com>
	<20100423030556.GA8012@localhost.localdomain>
	<20100423041106.GG3028@esdhcp04058.research.nokia.com>
Message-ID: <4BD4EBDB.6090209@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 4/23/2010 1:11 PM, Mika Westerberg wrote:
> On Fri, Apr 23, 2010 at 05:05:56AM +0200, ext Janboe Ye wrote:
>> I am trying this. But it seems need to do a lot work to make kdump
>> to work on other omap3 board.
> 
> You need to have userspace tools (in this case kexec-tools) which load the
> crashkernel into the running kernel. I'm planning to send my kexec-tools
> patches to upstream after the kernel part is accepted (so that they can be
> in sync) but I can provide you the patches if needed.
> 

I want to test your patches too. Can you send me the kexec-tools patches?

Thanks.

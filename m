From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 28 Feb 2011 11:11:56 +0000
Subject: [PATCH V4 2/4] ARM: Xilinx: Adding timer support to the platform
In-Reply-To: <a7f0ed14-296f-450d-af78-6771cd7281d1@VA3EHSMHS022.ehs.local>
References: <1298052881-14591-1-git-send-email-john.linn@xilinx.com>
	<1298052881-14591-2-git-send-email-john.linn@xilinx.com>
	<a7f0ed14-296f-450d-af78-6771cd7281d1@VA3EHSMHS022.ehs.local>
Message-ID: <20110228111156.GB8751@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 18, 2011 at 11:14:39AM -0700, John Linn wrote:
> The timer driver supports the Xilinx PS Timer Counter IP.
> 
> Signed-off-by: Kiran Sutariya <kiran.sutariya@einfochips.com>
> Signed-off-by: John Linn <john.linn@xilinx.com>
> ---

Looks nice to me.  It may be worth adding sched_clock() support to get 
better scheduler resolution in the future but that could come as a 
separate patch.

Jamie

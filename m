From: s.neumann@raumfeld.com (Sven Neumann)
Date: Thu, 04 Nov 2010 21:34:34 +0100
Subject: PXA3xx 2D graphics accelerator
In-Reply-To: <1288896241-8318-1-git-send-email-zonque@gmail.com>
References: <1288896241-8318-1-git-send-email-zonque@gmail.com>
Message-ID: <1288902874.19620.8.camel@bender>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-11-04 at 14:43 -0400, Daniel Mack wrote:

> Here's a rebased driver for the PXA3xx 2D graphics accelerator unit
> which acts as backend for the DirectFB userspace library. All the magic
> is in userspace, the driver is kept as simple as possible.
> 
> It's been awhile since I last proposed taking this code mainline, and
> in the meantime, the DirectFB people further improved the userspace
> driver part and fixed some bugs which I suspected to be problems
> related to this kernel driver. It's all good now, and the thing is
> ready for production use.

I should probably add that the fixes that were needed in DirectFB are
all in DirectFB 1.4.10, which was released yesterday.


Sven

From: rmk@arm.linux.org.uk (Russell King)
Date: Fri, 18 Sep 2009 12:51:04 +0100
Subject: [PATCH 1/2 v2] ARM: OMAP4: Fix NULL pointer dereference crash.
In-Reply-To: <87hbvytich.fsf@deeprootsystems.com>
References: <1250928012-5233-1-git-send-email-santosh.shilimkar@ti.com>
	<87hbvytich.fsf@deeprootsystems.com>
Message-ID: <20090918115104.GC4075@flint.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 23, 2009 at 10:56:14PM +0300, Kevin Hilman wrote:
> This should not be FOURPORT, it should just be a number.  In this case,
> it should be 3 (the others start from zero.)
> 
> The Zoom2 one should then be changed to something >= 4.

No it should not.  There's an enum to control the numbering of these.
Use that.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:

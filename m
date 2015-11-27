From: brad@heeltoe.com (Brad Parker)
Date: Fri, 27 Nov 2015 12:02:30 -0500
Subject: armv7 + lpae broken in 4.1.12+ ?
In-Reply-To: <20151127160615.GM8644@n2100.arm.linux.org.uk>
References: <5657952E.906@heeltoe.com> <20151127093601.GA25781@arm.com>
 <56587CF7.9060302@heeltoe.com> <20151127160615.GM8644@n2100.arm.linux.org.uk>
Message-ID: <56588CA6.50500@heeltoe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/15 11:06 AM, Russell King - ARM Linux wrote:
> Please check whether you have CONFIG_AEABI enabled. 
Yes.  That was it - sorry.  I didn't realize that was a config item (but 
with your explanation and a look at the makefile I see what it's 
doing).  I guess I was blissfully unaware that that option even 
existed.  But not any more :-)

thanks!

That option seem on by default for thumb2 kernels, but not for aarch32.

-brad

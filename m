From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Jan 2011 17:10:19 +0000
Subject: Current OMAP build failures
In-Reply-To: <878vyyx8s4.fsf@ti.com>
References: <20110106110336.GC31708@n2100.arm.linux.org.uk>
	<878vyyx8s4.fsf@ti.com>
Message-ID: <20110106171019.GF1198@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 06, 2011 at 09:05:15AM -0800, Kevin Hilman wrote:
> Hi Russell,
> 
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > I've observed the following issues while building 2.6.37 + my devel
> > branch.  I don't believe any of them to be due to anything in my tree,
> > so would be in 2.6.37 as well.
> 
> What defconfig are you using for these builds?

I couldn't say offhand because they're built from configs created a while
back.  I tend to just re-run the build with appropriate O= arguments to
test things.

I can send the defconfigs if it'd help.

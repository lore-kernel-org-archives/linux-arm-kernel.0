From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Nov 2009 14:24:29 +0000
Subject: [PATCH 1/2] ARM: PNX4008: fix i2c-pnx.c build errors
In-Reply-To: <20091120142128.GE4808@trinity.fluff.org>
References: <20091120135932.GA16920@n2100.arm.linux.org.uk>
	<f639bcd4278415ccf72dbc3b602670ac4dab040d.1258725164.git.rmk+kernel@arm.linux.org.uk>
	<20091120142128.GE4808@trinity.fluff.org>
Message-ID: <20091120142429.GD16920@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2009 at 02:21:29PM +0000, Ben Dooks wrote:
> On Fri, Nov 20, 2009 at 11:03:29AM +0000, Russell King - ARM Linux wrote:
> > ... caused by a missing include.
> 
> hi, thought this was fixed by the last fix set I sent which went in post
> 2.6.32-rc8.

Ok, I'll rebase my master branch and drop this change.

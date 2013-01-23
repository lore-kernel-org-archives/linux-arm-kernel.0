From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Jan 2013 16:46:20 +0000
Subject: Kernel API for SGI usage
In-Reply-To: <CANudz+tDzfU1xJgsjeuQBL7r5cwosvSEH6tct5aO8c+LvAm4pA@mail.gmail.com>
References: <CANudz+tDzfU1xJgsjeuQBL7r5cwosvSEH6tct5aO8c+LvAm4pA@mail.gmail.com>
Message-ID: <20130123164620.GR23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 12:39:54AM +0800, loody wrote:
> hi all:
> The other cores on my Soc need SGI to be waken up from reset state.
> Could any one header and functions I need to include and used for?

That's almost what every platform does.  Plenty of examples in the
platform SMP code for you to look at.

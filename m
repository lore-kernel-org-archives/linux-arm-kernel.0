From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Jan 2014 16:08:47 +0100
Subject: [PATCH V4 5/5] Documentation: power: reset: Add documentation for
 generic SYSCON reboot driver
In-Reply-To: <52E2F450.2070100@gmail.com>
References: <1390504801-24483-1-git-send-email-fkan@apm.com>
 <20140124182355.GF4758@e106331-lin.cambridge.arm.com>
 <52E2F450.2070100@gmail.com>
Message-ID: <3683633.QqePEXQehq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 January 2014 15:16:32 Marc C wrote:
> 
> > What's wrong with having a system clock unit binding, that the kernel
> > can decompose as appropriate?
> 
> From what I understand, the arm-soc maintainers want to reduce (and perhaps even
> eliminate) these board-specific constructs, and try to utilize common driver-code that
> resides in the "driver" folder. I can vouch for the syscon/regmap framework as something
> which would enable the effort.

While your statement is true in general, it doesn't seem to counter
what Mark R said above.

	Arnd

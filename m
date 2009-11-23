From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Nov 2009 10:38:14 +0000
Subject: [PATCH 09/19] drivers: serial: add support for Samsung S5PC110
	SoC uart
In-Reply-To: <000e01ca6911$24ea5d20$6ebf1760$%szyprowski@samsung.com>
References: <1258551194-16018-10-git-send-email-m.szyprowski@samsung.com>
	<1b68c6790911180614y355f656fs828177ecc845ec8e@mail.gmail.com>
	<20091118221345.GB4808@trinity.fluff.org>
	<1b68c6790911181844p3fb32525h11f79f942afb2d64@mail.gmail.com>
	<20091119103336.GB15460@sirena.org.uk>
	<1b68c6790911190305w33e777e3n1ed6b172d67f1639@mail.gmail.com>
	<20091119110827.GE9763@rakim.wolfsonmicro.main>
	<20091119113841.GJ13376@n2100.arm.linux.org.uk>
	<20091119114833.GH9763@rakim.wolfsonmicro.main>
	<000e01ca6911$24ea5d20$6ebf1760$%szyprowski@samsung.com>
Message-ID: <20091123103814.GA16741@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2009 at 01:09:23PM +0100, Marek Szyprowski wrote:
> What if a device does not operate properly when clocked from one of the
> available clock sources (lets say machine specific problem)? There must
> be a way of setting which clock(s) should not be considered when calculating
> best choice for particular device.

Do you have a real life case where this is true?

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 22 Sep 2012 14:22:32 +0100
Subject: [PATCH 2/5] ARM: Add interface for registering and calling
 firmware-specific operations
In-Reply-To: <20120922062322.GA6264@quad.lixom.net>
References: <1347524018-19301-1-git-send-email-t.figa@samsung.com>
 <1347524018-19301-3-git-send-email-t.figa@samsung.com>
 <20120922055015.GD32245@quad.lixom.net>
 <CAH9JG2XFVzyZH8rsBogVYRdD4dzWpKjX8JAQw0Sf7qJqgueqAg@mail.gmail.com>
 <20120922062322.GA6264@quad.lixom.net>
Message-ID: <20120922132232.GL15609@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 11:23:22PM -0700, Olof Johansson wrote:
> static void __iomem *default_cpu_boot_reg(int cpu)
> {
> 	return (void __iomem *)0;
> }

NULL is perfectly acceptable here.

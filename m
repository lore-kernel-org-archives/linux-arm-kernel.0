From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 19:37:51 +0100
Subject: [PATCH v7 3/3] arm64: Add architecture support for PCI
In-Reply-To: <20140319172140.GA16328@e106497-lin.cambridge.arm.com>
References: <1394811258-1500-1-git-send-email-Liviu.Dudau@arm.com>
 <20140319135619.GC6231@localhost>
 <20140319172140.GA16328@e106497-lin.cambridge.arm.com>
Message-ID: <8312584.jdZZuHGAjg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 March 2014 17:21:41 Liviu Dudau wrote:
> 
> My ultimate point is that no matter how long we argue about the shape of the functions that
> I've added into arch/arm64/kernel/pci.c I don't think we can get away without having that
> file, or at least not in the first phase if we want speedy integration into mainline.

Let me simplify the discussion here:

NAK to adding yet another architecture specific implementation.

	Arnd

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Dec 2014 11:10:45 +0000
Subject: regression: OMAP4 (next-20141204) (bisect to: ARM: 8208/1: l2c:
 Refactor the driver to use commit-like)
In-Reply-To: <54994B30.8040606@samsung.com>
References: <5481D913.9040109@ti.com> <5481D9BF.2090007@ti.com>
 <20141209165746.GA29935@kahuna> <54881589.20105@samsung.com>
 <20141211092945.GE11502@n2100.arm.linux.org.uk>
 <54897528.4030804@samsung.com>
 <20141222170411.GL11502@n2100.arm.linux.org.uk>
 <CAGo_u6pKUj9x8sCFY0wJCVDkBjT77xetu+XZ+DqWTjEWnvZePA@mail.gmail.com>
 <20141222172838.GM11502@n2100.arm.linux.org.uk>
 <54994B30.8040606@samsung.com>
Message-ID: <20141223111045.GN11502@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 23, 2014 at 12:00:00PM +0100, Marek Szyprowski wrote:
> I hope I did it right: https://lkml.org/lkml/2014/12/23/158
> Please test, because I have no access to Omap hardware.

Patch 1/8 looks like I'd expect it to.  Nishanth, please test with your
failing scenario, thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 May 2010 18:19:13 +0100
Subject: [PATCH 5/8] ARM: Fix the __arm_ioremap_caller() definition in
	nommu.c
In-Reply-To: <20100504164443.26355.41897.stgit@e102109-lin.cambridge.arm.com>
References: <20100504163823.26355.58568.stgit@e102109-lin.cambridge.arm.com>
	<20100504164443.26355.41897.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100504171913.GG30601@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 04, 2010 at 05:44:43PM +0100, Catalin Marinas wrote:
> Commit 31aa8fd6 introduced the __arm_ioremap_caller() function but the
> nommu.c version did not have the _caller suffix.

Ok.

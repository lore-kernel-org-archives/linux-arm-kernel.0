From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jan 2011 17:33:03 +0000
Subject: [PATCH 2/2] ARM: add a TCM memory test
In-Reply-To: <1287252398-13356-1-git-send-email-linus.walleij@stericsson.com>
References: <1287252398-13356-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110124173303.GB27080@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 16, 2010 at 08:06:38PM +0200, Linus Walleij wrote:
> This adds a simple test for the TCM memory, it will try to
> exercise it a bit by calling into it and reading/writing
> variables with canaries.

I wonder if arch/arm/kernel is the best place for something that
tests infrastructure.  Would samples/ be a better place?  Or
maybe arch/arm/tests/ (with an overall 'enable kernel testing'
option)?

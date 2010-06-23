From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Jun 2010 20:51:19 +0100
Subject: [PATCH 3/6] [ARM] Make __mem_pci() common to all ARM
	sub-architectures
In-Reply-To: <1277293938-25804-4-git-send-email-eric.y.miao@gmail.com>
References: <1277293938-25804-1-git-send-email-eric.y.miao@gmail.com>
	<1277293938-25804-4-git-send-email-eric.y.miao@gmail.com>
Message-ID: <20100623195119.GB25070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 23, 2010 at 07:52:15PM +0800, Eric Miao wrote:
> On all ARM sub-architectures, __mem_pci() is defined to be a 1:1
> mapping, make it a common definition for all.

This is not true for ebsa110, which you'll notice is missing from
this diffstat.

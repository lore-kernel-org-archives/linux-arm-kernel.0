From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Sep 2010 10:04:39 +0100
Subject: [PATCH] ARM: New option for generating uncompressed uImage.
In-Reply-To: <1284621783-8196-1-git-send-email-jonas.aberg@stericsson.com>
References: <1284621783-8196-1-git-send-email-jonas.aberg@stericsson.com>
Message-ID: <20100916090439.GC20197@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 16, 2010 at 09:23:03AM +0200, Jonas Aaberg wrote:
> Some systems do boot faster with an uncompressed kernel.

Do this externally.  uImage in the kernel build is a pain in the
backside because different people want different things from it.

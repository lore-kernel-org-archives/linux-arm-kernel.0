From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 10 Oct 2009 10:28:42 +0100
Subject: [PATCH 7/8] bcmring: add gpio csp code and header
In-Reply-To: <20091009211317.GF24851@broadcom.com>
References: <20091009211317.GF24851@broadcom.com>
Message-ID: <20091010092841.GA23492@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Why do you require this driver?  We already have a PL061 GPIO driver
in the kernel tree using the kernel's gpiolib infrastructure.

I hope this CSP stuff doesn't mean that you're going to have to duplicate
almost every kernel driver...

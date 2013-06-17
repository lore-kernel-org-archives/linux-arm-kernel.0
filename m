From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Jun 2013 19:48:56 +0100
Subject: [RFC PATCH 01/11] dma: amba-pl08x: Use bitmap to pass variant
 specific quirks
In-Reply-To: <1371416058-22047-2-git-send-email-tomasz.figa@gmail.com>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <1371416058-22047-2-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130617184856.GN2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 16, 2013 at 10:54:08PM +0200, Tomasz Figa wrote:
> Instead of defining new bool field in vendor_data struct for each quirk,
> it is more reasonable to use a single flags field and make each quirk
> use single bits.

Please explain why this is better over the existing system, and why it is
not just churn for code modification's sake.

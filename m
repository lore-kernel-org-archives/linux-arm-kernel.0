From: will.deacon@arm.com (Will Deacon)
Date: Mon, 2 Mar 2015 10:59:32 +0000
Subject: EDAC on arm64
In-Reply-To: <54F11133.70909@redhat.com>
References: <54F11133.70909@redhat.com>
Message-ID: <20150302105919.GA4434@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 28, 2015 at 12:52:03AM +0000, Jon Masters wrote:
> Have you considered reviving the patch you posted previously for EDAC
> support (the atomic_scrub read/write test piece dependency)?
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/249039.html

Well, we'd need a way to handle the non-coherent DMA case and it's really
not clear how to fix that.

Will

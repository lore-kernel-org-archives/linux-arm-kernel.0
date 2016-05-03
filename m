From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 3 May 2016 10:21:24 +0200
Subject: [PATCH v6 00/10] arm64: Add support for KVM with ACPI
In-Reply-To: <20160502125414.GR27057@io.lakedaemon.net>
References: <1460388780-914-1-git-send-email-julien.grall@arm.com>
 <57220C73.7010900@arm.com>
 <20160502125414.GR27057@io.lakedaemon.net>
Message-ID: <20160503082124.GA17923@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 02, 2016 at 12:54:14PM +0000, Jason Cooper wrote:
> On Thu, Apr 28, 2016 at 02:13:23PM +0100, Marc Zyngier wrote:
> > [+ Thomas, Jason]
> > 
> > Do you have any objection against this going through the KVM tree? The
> > dependencies are rather intricate, and Daniel gave us his green light
> > already for the clocksource part.
> > 
> > If you'd rather maintain the usual flow, please let us know and we'll
> > deal with it.
> 
> I've no objection.
> 
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> 
Just to be clear, that's on all the irqchip patches, right?

Thanks!
-Christoffer

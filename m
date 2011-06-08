From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 8 Jun 2011 13:33:10 +0300
Subject: [PATCH 4/4] x86: intel-iommu: move to drivers/iommu/
In-Reply-To: <1307524659.4771.12.camel@i7.infradead.org>
References: <1307522062-19273-1-git-send-email-ohad@wizery.com>
	<1307522062-19273-5-git-send-email-ohad@wizery.com>
	<1307524659.4771.12.camel@i7.infradead.org>
Message-ID: <BANLkTi=eRmd4h3+StGCR_-uVKo5F9fyd7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 8, 2011 at 12:17 PM, David Woodhouse <dwmw2@infradead.org> wrote:
> At least iova.o wants to go with it. That's one of the parts that is a
> candidate for harmonisation across IOMMU implementations, either by
> removing it or by having others use it too. It's how we allocate virtual
> I/O address space.
>
> I suspect the interrupt remapping support may well want to move with it
> too. It's no more out-of-place in drivers/iommu than it is in
> drivers/pci. And then you can certainly move dmar.o too.

Sounds good, thanks.

I'll wait a bit to see if there're more comments, and then re-send this one

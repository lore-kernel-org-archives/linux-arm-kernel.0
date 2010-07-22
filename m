From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Thu, 22 Jul 2010 13:47:36 +0900
Subject: [RFC 3/3] mm: iommu: The Virtual Contiguous Memory Manager
In-Reply-To: <20100722035026.GB14176@codeaurora.org>
References: <20100713090223.GB20590@n2100.arm.linux.org.uk>
	<20100714105922D.fujita.tomonori@lab.ntt.co.jp>
	<20100722035026.GB14176@codeaurora.org>
Message-ID: <20100722134708I.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 Jul 2010 20:50:26 -0700
Zach Pfeffer <zpfeffer@codeaurora.org> wrote:

> On Wed, Jul 14, 2010 at 10:59:43AM +0900, FUJITA Tomonori wrote:
> > On Tue, 13 Jul 2010 10:02:23 +0100
> > 
> > Zach Pfeffer said this new VCM infrastructure can be useful for
> > video4linux. However, I don't think we need 3,000-lines another
> > abstraction layer to solve video4linux's issue nicely.
> 
> Its only 3000 lines because I haven't converted the code to use
> function pointers.

The main point is adding a new abstraction that don't provide the huge
benefit.

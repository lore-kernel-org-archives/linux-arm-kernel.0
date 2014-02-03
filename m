From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 3 Feb 2014 09:41:25 -0800
Subject: [PATCH] arm: document "mach-virt" platform.
In-Reply-To: <52EF9D9F.5020600@codeaurora.org>
References: <1391098262-15944-1-git-send-email-ian.campbell@citrix.com>
 <52EA83D6.9050506@codeaurora.org> <20140203045638.GB4167@cbox>
 <52EF9D9F.5020600@codeaurora.org>
Message-ID: <20140203174125.GH4167@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 03, 2014 at 08:46:07AM -0500, Christopher Covington wrote:
> Hi Christoffer,
> 
> On 02/02/2014 11:56 PM, Christoffer Dall wrote:
> > On Thu, Jan 30, 2014 at 11:54:46AM -0500, Christopher Covington wrote:
> >> I think it would be informative to provide pointers here to commonly used
> >> paravirtualized devices, especially VirtIO PCI/MMIO.
> > 
> > I disagree: that would only encourage limited testing or assumptions
> > about these specific devices when really this platform is just a
> > bare-bones platform driven by device tree which should make no
> > preference, whatsoever, about which devices are used with the platform.
> 
> I'd be all for clearly stating that no assumptions can be made. Perhaps you
> can explain though how providing less documentation will result in more
> testing? The assertion does not currently make sense to me.
> 
If the documentation states that this is commonly used with virtio/xen
pv drivers, then I'm afraid people will just assume that's the only
devices the platform is used with.

Any mention of specific devices or features steers the attention away
from the essential point of this documentation.

I don't see how adding this text helps.  Such documentation should go
elsewhere, in QEMU, or a Xen/KVM web page or something like that.

Anyway, I'm not religious about this point.

-Christoffer

From: cov@codeaurora.org (Christopher Covington)
Date: Mon, 03 Feb 2014 08:46:07 -0500
Subject: [PATCH] arm: document "mach-virt" platform.
In-Reply-To: <20140203045638.GB4167@cbox>
References: <1391098262-15944-1-git-send-email-ian.campbell@citrix.com>
 <52EA83D6.9050506@codeaurora.org> <20140203045638.GB4167@cbox>
Message-ID: <52EF9D9F.5020600@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 02/02/2014 11:56 PM, Christoffer Dall wrote:
> On Thu, Jan 30, 2014 at 11:54:46AM -0500, Christopher Covington wrote:
>> I think it would be informative to provide pointers here to commonly used
>> paravirtualized devices, especially VirtIO PCI/MMIO.
> 
> I disagree: that would only encourage limited testing or assumptions
> about these specific devices when really this platform is just a
> bare-bones platform driven by device tree which should make no
> preference, whatsoever, about which devices are used with the platform.

I'd be all for clearly stating that no assumptions can be made. Perhaps you
can explain though how providing less documentation will result in more
testing? The assertion does not currently make sense to me.

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.

From: andrew.murray@arm.com (Andrew Murray)
Date: Mon, 22 Apr 2013 11:49:16 +0100
Subject: [PATCH v7 3/3] of/pci: mips: convert to common of_pci_range_parser
In-Reply-To: <517394C6.2060407@openwrt.org>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
 <1366107508-12672-4-git-send-email-Andrew.Murray@arm.com>
 <CACRpkdbBaT1OKr5t8HW4+8y_wSDmGxmewAyVMekx8S-K9s3K8Q@mail.gmail.com>
 <20130418125910.GA17128@arm.com>
 <20130418130919.GI27197@titan.lakedaemon.net>
 <5170F016.6050502@openwrt.org>
 <20130420223343.GB25724@titan.lakedaemon.net>
 <517394C6.2060407@openwrt.org>
Message-ID: <20130422104916.GA17007@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 21, 2013 at 08:27:02AM +0100, Gabor Juhos wrote:
> Hi Jason,
> 
> >> Sorry I had no time earlier, but I have tested this now on MIPS. The patch
> >> causes build errors unfortunately. Given the fact that this has been merged
> >> already, I will send a fixup patch.
> > 
> > Olof has dropped this branch from arm-soc, plase post the build error
> > and fix here so that it can be included in this series.
> 
> I have posted the patch to Olof two days ago. It has been CC'd to you as well
> but In case that it does not exists in your mailbox the patch can be found here:
> 
> https://patchwork.linux-mips.org/patch/5196/
> 
> However I can re-post the patch as a reply to this thread if you prefer that.

As this branch was dropped I have updated my patchset to include Grant's recent
feedback - I've also included Gabor's fixes to this patchset (and his sign-off).

If you include this new patchset in your branch the drivers that depend on it
will need to be updated to reflect the new naming of functions as suggested by
Grant.

Thanks,

Andrew Murray

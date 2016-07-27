From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 27 Jul 2016 14:57:52 +0900
Subject: [PATCH v1 0/4] arm64 kexec-tools patches
In-Reply-To: <20160726230526.GD28591@verge.net.au>
References: <cover.1468970114.git.geoff@infradead.org>
 <20160726230526.GD28591@verge.net.au>
Message-ID: <20160727055751.GD2363@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon,

On Wed, Jul 27, 2016 at 08:05:27AM +0900, Simon Horman wrote:
> Hi Geoff.
> 
> On Tue, Jul 19, 2016 at 11:28:13PM +0000, Geoff Levand wrote:
> > This series adds the core support for kexec re-boot on ARM64.
> > 
> > Linux kernel support for kexec reboot [1] has been merged to the ARM64
> > for-next/core branch with the expectation that it will be included in the v4.8
> > stable kernel release.
> > 
> > [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/438780.html
> 
> There seems to have been quite a bit of discussion of this patchset.

This patchset consists of Geoff's kexec support and my kdump support.
Since the former has already been queued in arm64 subtree's for-next
branch, it will go into v4.8.

So please note it is solely my kdump patches that is under reviews now
as v23[1].

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/445558.htmlk

Thanks,
-Takahiro AKASHI

> I am of a mind to release kexec-tools v2.0.12-rc1 (and thus v2.0.12)
> without these changes as the v4.7 kernel is already out and that
> is the timing I had in mind for kexec-tools v2.0.12 (the lateness on
> my shoulders).
> 
> The implication is the arm64 patches would likely end up in the v2.0.13
> release of kexec-tools which I aim to release around the time of the v4.9
> kernel.

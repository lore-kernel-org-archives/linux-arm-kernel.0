From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 29 Jun 2015 10:54:51 +0200
Subject: [GIT PULL 4/8] clk: tegra: Changes for v4.2-rc1
In-Reply-To: <20150620204104.9112.83328@quantum>
References: <1431524980-13599-1-git-send-email-thierry.reding@gmail.com>
 <1431524980-13599-5-git-send-email-thierry.reding@gmail.com>
 <20150520195459.GU31753@codeaurora.org>
 <555D7A5B.1070901@nvidia.com>
 <20150527195021.GA24204@codeaurora.org>
 <5566BDA5.5080104@nvidia.com> <20150618234126.9112.80705@quantum>
 <20150620204104.9112.83328@quantum>
Message-ID: <20150629085450.GC5431@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 20, 2015 at 01:41:04PM -0700, Michael Turquette wrote:
[...]
> I've decided to pull this in the interest of fairness. I'm taking the
> Exynos cpu clock patches, which will need to be updated in the future to
> use some new infrastructure for coordinating rate changes across
> multiple clock nodes. I'm merging the EMC stuff with the same
> expectation that it will need to migrate to the new infrastructure when
> it becomes available and we'll get rid of clk_hw_reparent.
> 
> Sound good?

Sounds good, thanks Mike. I'm sure we'll find someone to update this
when the framework changes are ready.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150629/757c7b10/attachment.sig>

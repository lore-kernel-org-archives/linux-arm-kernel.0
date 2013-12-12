From: broonie@kernel.org (Mark Brown)
Date: Thu, 12 Dec 2013 10:22:14 +0000
Subject: [PATCH 1/3] arm64: topology: Implement basic CPU topology support
In-Reply-To: <52A96201.509@linaro.org>
References: <1386792029-23148-1-git-send-email-broonie@kernel.org>
 <52A96201.509@linaro.org>
Message-ID: <20131212102214.GE11044@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 03:13:05PM +0800, Hanjun Guo wrote:

> The scheduler already used topology and cache sharing when
> CONFIG_SCHED_MC and/or CONFIG_SCHED_SMT are enable. can you
> add these configs for arm64 so the scheduler can use it?
> something like:

Right, yes - these should be added.  They got mistakenly included in the
patch for GTS which is obviously out of tree.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/bf0e1d68/attachment.sig>

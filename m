From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 14 Feb 2013 12:12:20 +0200
Subject: [PATCH 1/1] ARM: dt: add header to define tegra20 clocks
In-Reply-To: <1360823899-17846-1-git-send-email-hdoyu@nvidia.com>
References: <1360791198-29462-1-git-send-email-swarren@wwwdotorg.org>
 <1360823899-17846-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <20130214101220.GI3073@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 07:38:17AM +0100, Hiroshi Doyu wrote:
> To replace magic number in "clocks = <&tegra_car 28>;"
> 

But then we should probably also remove the enum tegra20_clk and replace it
with this header file. We should also consider removing the list of IDs from
the documentation and refer to the header file instead. Otherwise we will have
3 places which define the same IDs and we need to be sure they stay in sync...

Cheers,

Peter.

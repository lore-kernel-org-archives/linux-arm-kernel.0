From: will.deacon@arm.com (Will Deacon)
Date: Thu, 30 Mar 2017 15:43:10 +0100
Subject: [PATCH 0/4] ARM SMMU per-context TLB sync
In-Reply-To: <cover.1488907474.git.robin.murphy@arm.com>
References: <cover.1488907474.git.robin.murphy@arm.com>
Message-ID: <20170330144310.GI22160@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 07, 2017 at 06:09:03PM +0000, Robin Murphy wrote:
> The discussion around context-level access for Qualcomm SMMUs reminded
> me to dig up this patch I started ages ago and finish it off. As it's
> ended up, it's now a mini-series, with some new preparatory cleanup
> manifesting as patches 2 and 3. Patch 1 is broken out of patch 3 for
> clarity as somewhat of a fix in its own right, in that it's really an
> entirely unrelated thing which came up in parallel, but happens to
> be inherent to code I'm touching here anyway.

Apart from the first patch, most of this is looking good. Please can you
respin the series without the first patch and with my comments addressed?

Cheers,

Will

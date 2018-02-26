From: will.deacon@arm.com (Will Deacon)
Date: Mon, 26 Feb 2018 18:04:50 +0000
Subject: [PATCH v2 0/4] SMMU 52-bit address support
In-Reply-To: <cover.1512038236.git.robin.murphy@arm.com>
References: <cover.1512038236.git.robin.murphy@arm.com>
Message-ID: <20180226180449.GA26147@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Thu, Dec 14, 2017 at 04:58:49PM +0000, Robin Murphy wrote:
> Here's a (hopefully final) update of 52-bit SMMU support. The only
> material changes from v1[1] are a small cosmetic tweak to patch #1,
> and correction of the silly error in patch #2 as reported by Nate in
> testing.

This generally looks pretty good, but I have some review comments that I
think we should address before merging.

Cheers,

Will

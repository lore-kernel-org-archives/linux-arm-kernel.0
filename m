From: will.deacon@arm.com (Will Deacon)
Date: Wed, 9 Jul 2014 10:41:12 +0100
Subject: [PATCH v2] iommu/arm-smmu: fix some checkpatch issues
In-Reply-To: <1404838338-19295-1-git-send-email-mitchelh@codeaurora.org>
References: <1404838338-19295-1-git-send-email-mitchelh@codeaurora.org>
Message-ID: <20140709094111.GB9485@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 08, 2014 at 05:52:18PM +0100, Mitchel Humpherys wrote:
> Fix some issues reported by checkpatch.pl. Mostly whitespace, but also
> includes min=>min_t, kzalloc=>kcalloc, and kmalloc=>kmalloc_array.

Cheers, applied. I dropped the big list of things you fixed and just kept
the one you left, otherwise the message was a bit overwhelming.

Cheers,

Will

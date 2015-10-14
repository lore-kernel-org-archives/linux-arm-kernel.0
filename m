From: joro@8bytes.org (joro at 8bytes.org)
Date: Wed, 14 Oct 2015 13:50:13 +0200
Subject: [PATCH v6 0/3] arm64: IOMMU-backed DMA mapping
In-Reply-To: <561CF53E.7000809@arm.com>
References: <cover.1443718557.git.robin.murphy@arm.com>
 <561CF53E.7000809@arm.com>
Message-ID: <20151014115013.GM27420@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Tue, Oct 13, 2015 at 01:12:46PM +0100, Robin Murphy wrote:
> Anyway, what are your thoughts on taking this for 4.4? Since the
> dependencies are now in and we're at -rc5 already, I'm on the verge
> of reposting a self-contained version to go through arm64, as we
> really need to unblock all the follow-on development there (it's a
> shame that of the people I'm aware want this, it's only me and the
> Mediatek/Chrome guys here on the list saying so).

I plan to take it for 4.4, given the missing ack arrives. What are your
plans to resolve the remaining issues, like with the probe deferral
patch-set?


	Joerg

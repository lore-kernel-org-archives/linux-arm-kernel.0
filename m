From: will.deacon@arm.com (Will Deacon)
Date: Thu, 10 Oct 2013 16:44:56 +0100
Subject: [PATCH 1/7] iommu/arm-smmu: Introduce driver option handling
In-Reply-To: <1381358286-27065-2-git-send-email-andreas.herrmann@calxeda.com>
References: <1381358286-27065-1-git-send-email-andreas.herrmann@calxeda.com>
 <1381358286-27065-2-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <20131010154456.GA8528@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 09, 2013 at 11:38:00PM +0100, Andreas Herrmann wrote:
> Introduce handling of driver options. Options are set based on DT
> information when probing an SMMU device. The first option introduced
> is "arm,smmu-isolate-devices". (It will be used in the bus notifier
> block.)
> 
> Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
> ---

Looks good to me, thanks Andreas!

Will

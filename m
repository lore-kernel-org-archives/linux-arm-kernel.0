From: will.deacon@arm.com (Will Deacon)
Date: Tue, 20 Jun 2017 19:01:02 +0100
Subject: [PATCH v8 1/3] ACPI/IORT: Fixup SMMUv3 resource size for Cavium
 ThunderX2 SMMUv3 model
In-Reply-To: <1497968259-16390-2-git-send-email-gakula@caviumnetworks.com>
References: <1497968259-16390-1-git-send-email-gakula@caviumnetworks.com>
 <1497968259-16390-2-git-send-email-gakula@caviumnetworks.com>
Message-ID: <20170620180101.GD28035@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 07:47:37PM +0530, Geetha sowjanya wrote:
> From: Linu Cherian <linu.cherian@cavium.com>
> 
> Cavium ThunderX2 implementation doesn't support second page in SMMU
> register space. Hence, resource size is set as 64k for this model.
> 
> Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
> Signed-off-by: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
> ---
>  drivers/acpi/arm64/iort.c |   15 ++++++++++++++-
>  1 files changed, 14 insertions(+), 1 deletions(-)

Looks fine to me, but I need Lorenzo's ack on this.

Will

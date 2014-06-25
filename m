From: suravee.suthikulpanit@amd.com (Suravee Suthikulanit)
Date: Tue, 24 Jun 2014 22:04:08 -0500
Subject: [PATCH 2/2] arm/gic: Add supports for GICv2m MSI(-X)
In-Reply-To: <53A94A46.1010801@arm.com>
References: <1403569980-12913-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1403569980-12913-3-git-send-email-suravee.suthikulpanit@amd.com>
 <53A94A46.1010801@arm.com>
Message-ID: <53AA3C28.4080200@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/24/2014 4:52 AM, Marc Zyngier wrote:
> Overall, this requires to be re-architected. If you want to have a look
> at the way I did the GICv3 ITS support:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
> gicv3/its
>
> Thanks,

Thanks for the review comments. I'll take a look at the GICv3 and 
re-architect for the V2 patch set.

Suravee

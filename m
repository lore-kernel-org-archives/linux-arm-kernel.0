From: geethasowjanya.akula@gmail.com (Geetha Akula)
Date: Wed, 3 May 2017 16:02:34 +0530
Subject: [PATCH 2/3] iommu/arm-smmu-v3: Add workaround for Cavium
 ThunderX2 erratum #74
In-Reply-To: <20170503094717.GC8233@arm.com>
References: <1493293584-20287-1-git-send-email-gakula@caviumnetworks.com>
 <1493293584-20287-3-git-send-email-gakula@caviumnetworks.com>
 <20170427164237.GA7114@leverpostej> <20170427170030.GF1890@arm.com>
 <CANHdaibvzp22XEa3NnKAKUtrHcWGc9oUcnM8KubcYCzEfOaKJg@mail.gmail.com>
 <20170503094717.GC8233@arm.com>
Message-ID: <CANHdaib0hSFqPmD_WDFTWF6B4OSgFY+popNhK-wiWboTumbBng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

We will resubmit the patches based on IORT.


Thank you,
Geetha.

On Wed, May 3, 2017 at 3:17 PM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Geetha,
>
> On Tue, May 02, 2017 at 12:01:15PM +0530, Geetha Akula wrote:
>> SMMU_IIDR register is broken on T99, that the reason we are using MIDR.
>
> Urgh, that's unfortunate. In what way is it broken?
>
>> If using MIDR is not accepted, can we enable errata based on SMMU resource size?
>> some thing like below.
>
> No, you need to get your model number added to IORT after all if the IIDR
> can't uniqely identify the part.
>
> Sorry,
>
> Will

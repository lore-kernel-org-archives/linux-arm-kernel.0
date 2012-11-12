From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Mon, 12 Nov 2012 12:40:06 -0600
Subject: [PATCH v5 0/6] Move rest of omap-iommu to live in drivers/iommu
In-Reply-To: <CAK=WgbYR8UMyDjySJLRC0tEbJO3FaFgjWxceNwMyVdMgEgwPig@mail.gmail.com>
References: <20121102192221.4253.34303.stgit@muffinssi.local>
 <CAK=WgbYR8UMyDjySJLRC0tEbJO3FaFgjWxceNwMyVdMgEgwPig@mail.gmail.com>
Message-ID: <CALLhW=5WNg8X0nX8U+AExocyNKW=wJ7oS36xg4ENMnfyJkX8RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11 November 2012 03:39, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Fri, Nov 2, 2012 at 9:23 PM, Tony Lindgren <tony@atomide.com> wrote:
>> We need to move the iommu code to live under drivers
>> for arm common zImage support.
>
> For the iommu changes in the entire series:
>
> Acked-by: Ohad Ben-Cohen <ohad@wizery.com>
>
> Joerg, it might relieve some pain if this will go through Tony's tree,
> as there are some OMAP platform iommu changes coming in from Omar as
> well (part of which might have already been merged in the omap
> branches). Hope it's ok with both of you guys?
>
> Omar, do you still have any iommu changes coming in ?

Yes, I have the hwmod and runtime pm changes for iommu, I was waiting
for Tony to publish a branch with these changes to submit (as per
Tony's suggestion), but I already have the patches rebased onto these.

I will submit them.

Cheers,

Omar

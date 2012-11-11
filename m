From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sun, 11 Nov 2012 11:39:57 +0200
Subject: [PATCH v5 0/6] Move rest of omap-iommu to live in drivers/iommu
In-Reply-To: <20121102192221.4253.34303.stgit@muffinssi.local>
References: <20121102192221.4253.34303.stgit@muffinssi.local>
Message-ID: <CAK=WgbYR8UMyDjySJLRC0tEbJO3FaFgjWxceNwMyVdMgEgwPig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 2, 2012 at 9:23 PM, Tony Lindgren <tony@atomide.com> wrote:
> We need to move the iommu code to live under drivers
> for arm common zImage support.

For the iommu changes in the entire series:

Acked-by: Ohad Ben-Cohen <ohad@wizery.com>

Joerg, it might relieve some pain if this will go through Tony's tree,
as there are some OMAP platform iommu changes coming in from Omar as
well (part of which might have already been merged in the omap
branches). Hope it's ok with both of you guys?

Omar, do you still have any iommu changes coming in ? Can we get
everything merged to the same tree ?

Thanks!
Ohad.

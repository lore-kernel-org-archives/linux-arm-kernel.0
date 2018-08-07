From: jmkrzyszt@gmail.com (Janusz Krzysztofik)
Date: Tue, 07 Aug 2018 23:55:14 +0200
Subject: [RFC PATCH v2 01/12] mtd: rawnand: ams-delta: Assign
 mtd->dev.parent, not mtd->owner
In-Reply-To: <604ff0fb-07d5-9068-2f69-41198f3d9854@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-2-jmkrzyszt@gmail.com>
 <604ff0fb-07d5-9068-2f69-41198f3d9854@gmail.com>
Message-ID: <5203112.3RHHgWL3HE@z50>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Tuesday, August 7, 2018 1:54:10 AM CEST Marek Vasut wrote:
> On 08/07/2018 12:29 AM, Janusz Krzysztofik wrote:
> > Fix missing mtd->dev.parent assignment and drop useless mtd->owner.
> 
> You fail to explain why this fix is required.

OK, I'll have a look at similar patches from the past and add an explanation.

Thanks,
Janusz

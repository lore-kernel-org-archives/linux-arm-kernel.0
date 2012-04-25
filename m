From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Wed, 25 Apr 2012 09:38:57 +0200
Subject: [PATCH 00/33] Use common macro to define resources
In-Reply-To: <20120425041939.GL9142@game.jcrosoft.org>
References: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
 <20120425041939.GL9142@game.jcrosoft.org>
Message-ID: <201204250938.58397.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Mittwoch, 25. April 2012, 06:19:39 schrieb Jean-Christophe PLAGNIOL-
VILLARD:
> On 09:42 Wed 25 Apr     , Tushar Behera wrote:
> > There are some helper macros (DEFINE_RES_XXX) for defining resource
> > structures. This patchset migrates all the earlier resource
> > definitions (within Samsung specific code base) to use these macros.
> > 
> > In some cases, it was not possible to use DEFINE_RES_IRQ() macro because
> > of usage of additional flags. In those cases, DEFINE_RES_NAMED() macro
> > is used instead.
> > 
> > The patches are rebased on top of Kukjin's for-next branch at this
> > commit.
> > 
> > d0ee53a Merge branch 'next/board-samsung' into for-next
> 
> is this really necessary as we switch to DT this code will be droped

As far as I know legacy SoCs are allowed to keep being non-DT and I don't see 
the older Samsung SoCs (especially the S3C24XX ones) changing to DT anytime 
soon, as they don't see any new development but only bug fixes currently.


> for my point of view it's cosmetics change
it is, but it also makes the code more readable


Heiko

From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 5 May 2010 12:14:45 +0100
Subject: [PATCH v2 1/2] regulator: make 88pm860x sharing one driver
	structure
In-Reply-To: <k2h771cded01005042234v438edb71h5456bf19fdb474b9@mail.gmail.com>
References: <k2h771cded01005042234v438edb71h5456bf19fdb474b9@mail.gmail.com>
Message-ID: <20100505111445.GB5754@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 05, 2010 at 01:34:53AM -0400, Haojian Zhuang wrote:
> From 782297964a48a3b8547a99de3b5c24d8f02b99ec Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Thu, 29 Apr 2010 13:33:50 -0400
> Subject: [PATCH] regulator: make 88pm860x sharing one driver structure
> 
> Remove a lot of driver structures in 88pm860x driver. Make regulators share
> one driver structure.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

If you've actually revised a patch please don't carry forward people's
acks unless they've preapproved a change.  It can also be helpful to
ensure that people have some idea on what the changes are - sometimes
that'll be clear from the discussion of the previous posting, in other
cases adding a note along with the diffstat can be helpful.

In this case I can't quite spot the difference so the patch is OK.

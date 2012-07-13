From: robherring2@gmail.com (Rob Herring)
Date: Fri, 13 Jul 2012 14:48:52 -0500
Subject: [PATCH 00/11] make struct of_device_id.data const
In-Reply-To: <20120713174935.GN592@pengutronix.de>
References: <1342182734-321-1-git-send-email-y> <5000175E.4070702@gmail.com>
 <20120713134638.GH592@pengutronix.de> <201207131624.27266.arnd@arndb.de>
 <20120713174935.GN592@pengutronix.de>
Message-ID: <50007BA4.90804@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13/2012 12:49 PM, Uwe Kleine-K?nig wrote:

[snip]

> I guess this results in a warning until after patch 10 is applied? (A
> few more down below.)
> 
> In the meantime I expanded my defconfig build script to handle powerpc,
> too. I'll check these. I think I'll have to let the build run over
> night...

I'm not certain but just an allyesconfig build on powerpc should be
sufficient rather than building defconfigs. We still dream about doing
that on ARM.

Rob

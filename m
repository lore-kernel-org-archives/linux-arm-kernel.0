From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 28 Feb 2012 10:18:50 +0000
Subject: [PATCH v3 0/2] Device tree support for TWL regulators
In-Reply-To: <4F4C691C.2000600@ti.com>
References: <1330338961-31765-1-git-send-email-rnayak@ti.com>
 <4F4B73C8.8070807@ti.com> <4F4B7798.6000300@ti.com>
 <20120227134112.GB3191@opensource.wolfsonmicro.com>
 <4F4B8A85.7060603@ti.com>
 <20120227140356.GF3191@opensource.wolfsonmicro.com>
 <4F4B9166.7020909@ti.com>
 <20120227145345.GJ3191@opensource.wolfsonmicro.com>
 <4F4C691C.2000600@ti.com>
Message-ID: <20120228101850.GA3121@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2012 at 11:11:48AM +0530, Rajendra Nayak wrote:

> changes have no dependencies with any other DT series. I will repost
> all of Tero/Peter and my changes (to add DT support to the driver) as
> one single series and drop the dts file updates, which I guess can go
> via Tony/OMAP tree.

Yes, that sounds like a good plan - the DTS changes are largely
orthogonal to the code changes and don't need to go via the same path
(this is true in general, the DTSs are pretty horrible for merge
issues).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120228/b1bcadfe/attachment.sig>

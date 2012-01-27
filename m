From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 27 Jan 2012 11:19:33 +0000
Subject: [PATCH v2 2/2] regulator: add device tree support for max8997
In-Reply-To: <4F227530.3050708@samsung.com>
References: <1326353738-26864-1-git-send-email-thomas.abraham@linaro.org>
 <1326353738-26864-3-git-send-email-thomas.abraham@linaro.org>
 <4F1FD1A5.1060305@samsung.com>
 <20120125112602.GB2991@opensource.wolfsonmicro.com>
 <4F1FEF55.8030604@samsung.com>
 <20120125133254.GJ3687@opensource.wolfsonmicro.com>
 <4F217100.6020105@samsung.com>
 <20120126161744.GB19703@opensource.wolfsonmicro.com>
 <4F227530.3050708@samsung.com>
Message-ID: <20120127111932.GC32008@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2012 at 10:58:08AM +0100, Karol Lewandowski wrote:
> >>On 25.01.2012 12:22, Mark Brown wrote:

> >I'm sorry, this makes no sense.  Setting a value in the constraints is
> >not going to have any impact on the value reported by the driver, it
> >never has.

> ... with the exception of fixed regulator, that is. This is from
> where I got my flawed understanding.

Note also that this only happens for device tree - with platform data
there's separate platform data for the voltage.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120127/c097b06d/attachment-0001.sig>

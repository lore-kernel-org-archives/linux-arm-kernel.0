From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 27 Nov 2014 14:08:43 +0100
Subject: [PATCH v4 1/7] mfd: max77686/802: Remove support for board files
In-Reply-To: <20141127130301.GX7712@sirena.org.uk>
References: <1417087253-12306-1-git-send-email-k.kozlowski@samsung.com>
 <1417087253-12306-2-git-send-email-k.kozlowski@samsung.com>
 <20141127130301.GX7712@sirena.org.uk>
Message-ID: <1417093723.32141.1.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On czw, 2014-11-27 at 13:03 +0000, Mark Brown wrote:
> On Thu, Nov 27, 2014 at 12:20:47PM +0100, Krzysztof Kozlowski wrote:
> > The driver is used only on Exynos based boards with DTS support.
> > After removal of board file support from max77686 and max77802 regulator
> > drivers, the MFD driver can be converted to DTS-only version. This
> > simplifies a little the code:
> 
> Why is this a dependency for new features in the regulator core?
My mistake, I based this patchset on regulator cleanup but this MFD
change is not needed for it. It can be skipped here. Sorry for the
noise.

Best regards,
Krzysztof

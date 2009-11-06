From: laforge@gnumonks.org (Harald Welte)
Date: Fri, 6 Nov 2009 12:31:46 +0900
Subject: [PATCH 15/17] ARM: S5PC1xx: add platform helpers for SDHCI
	host controllers
In-Reply-To: <1255421482-26455-16-git-send-email-m.szyprowski@samsung.com>
References: <1255421482-26455-7-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-8-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-9-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-10-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-11-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-12-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-13-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-14-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-15-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-16-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20091106033146.GQ3913@prithivi.gnumonks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2009 at 10:11:20AM +0200, Marek Szyprowski wrote:
> Samsung S5PC100 has 3 SDHCI controllers compatible with the one known from
> previous SoCs series. Add required platform setup and support code that
> the devices can be used with sdhci-s3c driver.

this patch, plus the following two patches also should be merged. I think they
are straight-forward .
-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

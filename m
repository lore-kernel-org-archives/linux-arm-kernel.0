From: laforge@gnumonks.org (Harald Welte)
Date: Fri, 6 Nov 2009 12:30:09 +0900
Subject: [PATCH 12/17] ARM: S5PC1xx: add platform helpers for i2c
	adapter devices
In-Reply-To: <1255421482-26455-13-git-send-email-m.szyprowski@samsung.com>
References: <1255421482-26455-4-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-5-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-6-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-7-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-8-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-9-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-10-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-11-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-12-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-13-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20091106033009.GO3913@prithivi.gnumonks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2009 at 10:11:17AM +0200, Marek Szyprowski wrote:
> Samsung S5PC100 has I2C bus controller compatible with the one known from
> previous SoCs series. Add required platform setup and support code that
> it can be used with s3c2410-i2c driver.

this is straight forward.  I think Ben should merge it.
-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

From: laforge@gnumonks.org (Harald Welte)
Date: Fri, 6 Nov 2009 12:23:01 +0900
Subject: [PATCH 07/17] ARM: S5PC1xx: add gpiolib and external/gpio
	interrupt support
In-Reply-To: <1255421482-26455-8-git-send-email-m.szyprowski@samsung.com>
References: <1255421482-26455-1-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-2-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-3-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-4-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-5-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-6-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-7-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-8-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20091106032301.GK3913@prithivi.gnumonks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2009 at 10:11:12AM +0200, Marek Szyprowski wrote:
> Add support for gpiolib calls. This is based on the gpiolib implementation
> from plat-s3c64xx tree.

I think this is also the right way.  We definitely want gpiolib support.

Ben, what do you think?

Regards,
	Harald
-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

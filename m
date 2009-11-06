From: laforge@gnumonks.org (Harald Welte)
Date: Fri, 6 Nov 2009 12:29:05 +0900
Subject: [PATCH 09/17] ARM: S5PC1xx: add platform helpers for s3c-fb device
In-Reply-To: <1255421482-26455-10-git-send-email-m.szyprowski@samsung.com>
References: <1255421482-26455-1-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-2-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-3-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-4-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-5-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-6-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-7-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-8-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-9-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-10-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20091106032905.GM3913@prithivi.gnumonks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2009 at 10:11:14AM +0200, Marek Szyprowski wrote:
> Samsung S5PC100 has LCD-controller compatible with the one known from
> previous SoCs series. Add required platform setup and support code that
> it can be used with s3c-fb driver.

Once again i like teh idea and purpose of the patch.

However, I don't like that we copy an entire header file and now have two
copies of the same header file in the kernel tree.

>  arch/arm/mach-s5pc100/include/mach/regs-fb.h |  259 ++++++++++++++++++++++++++

I'm quite sure that there must be a solution where we can avoid copying the
file to two places.

-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

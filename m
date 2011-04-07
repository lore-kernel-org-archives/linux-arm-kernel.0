From: vapier@gentoo.org (Mike Frysinger)
Date: Thu, 7 Apr 2011 02:12:22 -0400
Subject: [PATCH] spi: Fix race condition in stop_queue()
In-Reply-To: <1302101355-31187-1-git-send-email-anarsoul@gmail.com>
References: <201104061746.44134.anarsoul@gmail.com>
	<1302101355-31187-1-git-send-email-anarsoul@gmail.com>
Message-ID: <BANLkTin8_WF4beQKP7fEF_wBPXZrgHOFHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 6, 2011 at 10:49, Vasily Khoruzhick wrote:
> ?drivers/spi/spi_bfin5xx.c | ? ?2 +-

seems to past my smoke test.
Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike

From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 May 2012 17:43:49 +0000
Subject: [PATCH] ixp4xx: fix compilation by adding gpiolib support
In-Reply-To: <1337789991-5283-1-git-send-email-richardcochran@gmail.com>
References: <1337789991-5283-1-git-send-email-richardcochran@gmail.com>
Message-ID: <201205231743.50262.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 May 2012, Richard Cochran wrote:
> Once again, ixp4xx no longer even compiles. This patch fixes the issue
> by converting over to gpiolib. This patch was first made by Imre and
> posted by Marc, and I added in Russell's suggestion to empty the gpio
> header file.
> 
> This fix should also go for 3.1, 3.2, 3.3, and 3.4.
> 
> Signed-off-by: Richard Cochran <richardcochran@gmail.com>
> Cc: <stable@vger.kernel.org>

So has every kernel since 3.1 been broken, or is it just broken now
but a good idea to backport anyway?

	Arnd

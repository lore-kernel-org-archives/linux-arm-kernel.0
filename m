From: ynvich@gmail.com (Sergei Ianovich)
Date: Fri, 10 Jan 2014 03:12:56 +0400
Subject: [PATCH v2 00/16] ARM: support for ICP DAS LP-8x4x (with dts)
In-Reply-To: <201312190630.11087.arnd@arndb.de>
References: <1386543229-1542-1-git-send-email-ynvich@gmail.com>
 <201312182210.30544.arnd@arndb.de>
 <1387401646.31516.14.camel@host5.omatika.ru>
 <201312190630.11087.arnd@arndb.de>
Message-ID: <1389309176.32346.1.camel@host5.omatika.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-12-19 at 06:30 +0100, Arnd Bergmann wrote:
> This would work only if we can probe the devices behind the external
> bus controller before the controller itsef has been set up, since
> the initialization order can depend on a number of things but not
> the bus hierarchy. It will also work if the code setting up the
> bus controller can be guaranteed to run before we call
> of_platform_populate for the regular devices, which is probably
> the best solution here.

There has been no activity for 3 weeks. Could we resume the series?

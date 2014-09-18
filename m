From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 18 Sep 2014 07:55:53 +0200
Subject: [PATCH] arm:extend the reserved mrmory for initrd to be page
 aligned
In-Reply-To: <35FD53F367049845BC99AC72306C23D103D6DB491616@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D103D6DB491616@CNBJMBX05.corpusers.net>
Message-ID: <20140918055553.GO3755@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

just some commit log nit picking:

$Subject ~= s/mrmory/memory/

And also "ARM: " is the more typical prefix. Don't know if there is a
best practice for patches touching both arm and arm64. (But assuming
this will go through Russell's patch tracker this doesn't matter much.)

On Thu, Sep 18, 2014 at 09:58:10AM +0800, Wang, Yalin wrote:
> this patch extend the start and end address of initrd to be page aligned,
This patch extends ...

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Jul 2011 22:52:16 +0200
Subject: [PATCH v4 2/2] ARM: l2x0: Add OF based initialization
In-Reply-To: <1309984979-8847-2-git-send-email-robherring2@gmail.com>
References: <1309984979-8847-1-git-send-email-robherring2@gmail.com>
	<1309984979-8847-2-git-send-email-robherring2@gmail.com>
Message-ID: <201107062252.16667.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 July 2011 22:42:59 Rob Herring wrote:
> 
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This adds probing for ARM L2x0 cache controllers via device tree. Support
> includes the L210, L220, and PL310 controllers. The binding allows setting
> up cache RAM latencies and filter addresses (PL310 only).
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

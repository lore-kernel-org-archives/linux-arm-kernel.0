From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Aug 2017 21:44:39 +0200
Subject: [PATCH] ARM: bcm283x: Fix SMP for old dtb files
In-Reply-To: <1503515314-16576-1-git-send-email-stefan.wahren@i2se.com>
References: <1503515314-16576-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <CAK8P3a303oEejUZQ3bXVdTLwsWCC2BiLqzigCYbw6T0tAF=Y+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 23, 2017 at 9:08 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Since "irqchip: bcm2836: Move SMP startup code to arch/arm" the SMP
> for BCM2836 and BCM2837 (32 bit) depends on commit "ARM: dts: bcm283x:
> Add 32-bit enable method for SMP". This patch fixes SMP for older
> dtb files.
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Looks good to me, thanks for the update.

Acked-by: Arnd Bergmann <arnd@arndb.de>

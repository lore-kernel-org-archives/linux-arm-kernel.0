From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 May 2013 15:34:08 +0200
Subject: [PATCH 03/21] ARM: shmobile: don't call irqchip_init
 unconditionally
In-Reply-To: <CABYn4sxrcGmnTAJcQR23nMGy8JvqyDrgPOXF4yBFFU_4C8Pc_g@mail.gmail.com>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
 <201305081416.06611.arnd@arndb.de>
 <CABYn4sxrcGmnTAJcQR23nMGy8JvqyDrgPOXF4yBFFU_4C8Pc_g@mail.gmail.com>
Message-ID: <201305081534.08336.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 May 2013, Bastian Hecht wrote:
> 
> 2013/5/8 Arnd Bergmann <arnd@arndb.de>:
> 
> I have sent out a patch adding an empty irqchip_init() when
> CONFIG_IRQCHIP is not set with the subject
> [PATCH] irqchip: Add irqchip_init dummy function

Ah, I missed that one. Is it already in linux-next?

	Arnd

From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 5 Aug 2014 13:42:48 +0800
Subject: [PATCH] ARM: i.MX: Remove mxc_arch_reset_init_dt() call for i.MX1
In-Reply-To: <1407067830-10985-1-git-send-email-shc_work@mail.ru>
References: <1407067830-10985-1-git-send-email-shc_work@mail.ru>
Message-ID: <20140805054246.GF2167@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 03, 2014 at 04:10:30PM +0400, Alexander Shiyan wrote:
> i.MX1 watchdog is not compatible with other i.MX SOCs, so
> remove call of mxc_arch_reset_init_dt() for this CPU.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Amend the change into 'ARM: i.MX1: Add devicetree support'.

Shawn

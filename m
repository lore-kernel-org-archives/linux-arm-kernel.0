From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 6 Jan 2010 15:17:39 +0800
Subject: sharp c-3000 aka spitz: fix warn_on introduced in 2.6.32-rc1
In-Reply-To: <20100106071026.GD1382@ucw.cz>
References: <20100106071026.GD1382@ucw.cz>
Message-ID: <f17812d71001052317h2bf25fady6bd729b35ef6db63@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 6, 2010 at 3:10 PM, Pavel Machek <pavel@ucw.cz> wrote:
>
> Sharp-SL code uses strange, complex grouping of gpios for wakeups
> toggling. Fortunately, it is unneeded in recent kernels (and actually
> provokes WARN_ONs during resume). Remove it.
>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Pavel,

The code to be removed below is used to support pxa27x_keypad
to be able to resume from sleep. What's the exact reason to remove
this on spitz?

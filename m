From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 13 Mar 2011 11:15:46 +0100
Subject: [PATCH 1/8] ARM: PXA: Z2: Use only power button as wake source
In-Reply-To: <1299839023-16601-1-git-send-email-anarsoul@gmail.com>
References: <1299839023-16601-1-git-send-email-anarsoul@gmail.com>
Message-ID: <20110313101546.GA1827@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> It's very easy to press some keypad key when Z2 is closed,
> so to prevent unexpected wakeups, use only 'Power' key to wake
> Z2 from sleep.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

> -	GPIO34_KP_MKIN_3	| WAKEUP_ON_LEVEL_HIGH,
> -	GPIO38_KP_MKIN_4	| WAKEUP_ON_LEVEL_HIGH,
> -	GPIO16_KP_MKIN_5	| WAKEUP_ON_LEVEL_HIGH,
> -	GPIO17_KP_MKIN_6	| WAKEUP_ON_LEVEL_HIGH,
> +	GPIO100_KP_MKIN_0	/*| WAKEUP_ON_LEVEL_HIGH*/,
> +	GPIO101_KP_MKIN_1	/*| WAKEUP_ON_LEVEL_HIGH*/,
> +	GPIO102_KP_MKIN_2	/*| WAKEUP_ON_LEVEL_HIGH*/,
> +	GPIO34_KP_MKIN_3	/*| WAKEUP_ON_LEVEL_HIGH*/,
> +	GPIO38_KP_MKIN_4	/*| WAKEUP_ON_LEVEL_HIGH*/,
> +	GPIO16_KP_MKIN_5	/*| WAKEUP_ON_LEVEL_HIGH*/,
> +	GPIO17_KP_MKIN_6	/*| WAKEUP_ON_LEVEL_HIGH*/,

Please remove the code, don't just comment it out.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

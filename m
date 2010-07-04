From: eric.y.miao@gmail.com (Eric Miao)
Date: Sun, 4 Jul 2010 23:55:56 +0800
Subject: [PATCH 23/33] Removing dead BACKLIGHT_CORGI
In-Reply-To: <AANLkTikeR3hzF8KGBxPoRTiAmXXK62UB4CZ4t8tctC5_@mail.gmail.com>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<daefd019d1a302665a0cc5817ed50cfb4b7b1c44.1277911346.git.siccegge@cs.fau.de>
	<AANLkTikeR3hzF8KGBxPoRTiAmXXK62UB4CZ4t8tctC5_@mail.gmail.com>
Message-ID: <AANLkTimhzM9N77oezsWoWk_lmDvpLnzrZBmW5KLcoR9C@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 1, 2010 at 11:50 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Thu, Jul 1, 2010 at 12:01 AM, Christoph Egger <siccegge@cs.fau.de> wrote:
>> BACKLIGHT_CORGI doesn't exist in Kconfig, therefore removing all
>> references for it from the source code.
>>
>> Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
>
> BACKLIGHT_CORGI was renamed to BACKLIGHT_GENERIC in commit
> d00ba726725c6f41e43df00f83e484ba8f9fac5c.
>
> Since it's now safe to completely transition to LCD_CORGI, which not only
> includes the backlight functionality but also the LCD, so
>
> Acked-by: Eric Miao <eric.y.miao@gmail.com>
>

Applied.

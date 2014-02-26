From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 26 Feb 2014 06:44:58 -0800
Subject: [PATCH 1/5] ARM: davinci: remove tnetv107x support
In-Reply-To: <1393418614-3968549-2-git-send-email-arnd@arndb.de> (Arnd
 Bergmann's message of "Wed, 26 Feb 2014 13:43:30 +0100")
References: <1393418614-3968549-1-git-send-email-arnd@arndb.de>
 <1393418614-3968549-2-git-send-email-arnd@arndb.de>
Message-ID: <7hk3ciylud.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> The tnetv107x support does not compile, and seems to have been broken
> for a while with nobody caring to fix it. So far everyone I asked
> said it's probably dead and completely unused and will never again
> be needed in a future kernel release, so let's delete it.
>
> If someone finds a use for this code later and is able to get it
> to work again, we can always revert the removal.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Kevin Hilman <khilman@linaro.org>

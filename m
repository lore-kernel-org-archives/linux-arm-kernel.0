From: stigge@antcom.de (Roland Stigge)
Date: Thu, 01 Mar 2012 21:42:21 +0100
Subject: [PATCH v3] lpc32xx: Added ethernet driver
In-Reply-To: <201202271949.03144.arnd@arndb.de>
References: <1330364539-23152-1-git-send-email-stigge@antcom.de>
 <201202271949.03144.arnd@arndb.de>
Message-ID: <4F4FDF2D.5040508@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/02/12 20:49, Arnd Bergmann wrote:
> Are you sure that npx is actually the origin of this controller?
> If they only licensed the IP themselves, it would be better to list
> it under the name of the actual creator so that the next person
> who has the same core can find it.

I have no hint for another origin of this core (see manual). However, as
soon as we get new info on this, we can move the driver easily.

Thanks to all of you for your suggestions, I will include all the
suggested changes an repost an updated driver.

Roland

From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 30 May 2013 09:50:08 +0800
Subject: [PATCH] SPI: Unify simple platform data for some controllers
In-Reply-To: <1962597.10ArYKg8M9@wuerfel>
References: <1369809742-4220-1-git-send-email-shc_work@mail.ru>
 <20130529144909.GT3660@sirena.org.uk>
 <1369847158.250798748@f433.i.mail.ru> <1962597.10ArYKg8M9@wuerfel>
Message-ID: <20130530015006.GA1875@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 08:10:05PM +0200, Arnd Bergmann wrote:
> The plan for i.MX is to move to DT-only in the long run, but
> AFAIK a lot of people still rely on board files and they are
> not trivial to convert without access to test hardware.
> 
> Any new i.MX hardware should certainly be DT-only.
> 
> Shawn can probably comment better on the time line.
> 
It's progressing slowly, and I can not really commit a time line because
there are too many board files to be converted, and more importantly
I haven't seen too much effort from board owners on this work.

Shawn

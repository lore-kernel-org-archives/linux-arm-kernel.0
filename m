From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 11 Nov 2018 12:29:50 +0100
Subject: [PATCH] ARM: OMAP1: ams-delta: Provide GPIO lookup table for LED
 device
In-Reply-To: <20181105232349.17351-1-jmkrzyszt@gmail.com>
References: <20181105232349.17351-1-jmkrzyszt@gmail.com>
Message-ID: <20181111112950.GB27666@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2018-11-06 00:23:49, Janusz Krzysztofik wrote:
> Global GPIO numbers no longer have to be passed to leds-gpio driver,
> replace their assignment with a lookup table.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181111/0ab2efb7/attachment.sig>

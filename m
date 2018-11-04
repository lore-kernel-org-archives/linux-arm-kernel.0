From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 4 Nov 2018 12:32:01 +0100
Subject: [PATCH] DT: marvell,mmp2: fix the gpio interrupt cell number
In-Reply-To: <20181008204850.130161-1-lkundrak@v3.sk>
References: <20181008204850.130161-1-lkundrak@v3.sk>
Message-ID: <20181104113200.GD23864@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2018-10-08 22:48:50, Lubomir Rintel wrote:
> gpio-pxa uses two cell to encode the interrupt source: the pin number
> and the trigger type. Adjust the device node accordingly.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181104/70aa5bba/attachment-0001.sig>

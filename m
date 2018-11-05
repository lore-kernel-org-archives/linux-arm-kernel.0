From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 5 Nov 2018 10:19:44 +0100
Subject: [PATCH 06/14] ARM: aspenite: add an instance of pxa-usb-phy
In-Reply-To: <20180822204307.13251-7-lkundrak@v3.sk>
References: <20180822204307.13251-1-lkundrak@v3.sk>
 <20180822204307.13251-7-lkundrak@v3.sk>
Message-ID: <20181105091944.GH4439@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2018-08-22 22:42:59, Lubomir Rintel wrote:
> This will replace the pxa168_sph_pdata.phy_{de,}init().
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

I'd merge this with the previous patch if it is easy. Your patches are
a bit too small...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181105/a79cf79b/attachment.sig>

From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 4 Nov 2018 13:31:38 +0100
Subject: [PATCH 08/15] Platform: OLPC: Move EC-specific functionality out
 from x86
In-Reply-To: <20181010172300.317643-9-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-9-lkundrak@v3.sk>
Message-ID: <20181104123138.GB23864@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2018-10-10 19:22:53, Lubomir Rintel wrote:
> It is actually plaform independent. Move it to the olpc-ec driver from
> the X86 OLPC platform, so that it could be used by the ARM based laptops
> too.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181104/d8f772f1/attachment.sig>

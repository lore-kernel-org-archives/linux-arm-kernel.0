From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 4 Nov 2018 15:39:14 +0100
Subject: [PATCH 14/15] power: supply: olpc_battery: Avoid using
 platform_info
In-Reply-To: <20181010172300.317643-15-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-15-lkundrak@v3.sk>
Message-ID: <20181104143914.GG23864@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2018-10-10 19:22:59, Lubomir Rintel wrote:
> This wouldn't work on the DT-based ARM platform. Let's read the EC version
> directly from the EC driver instead.
> 
> This makes the driver no longer x86 specific.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181104/03906147/attachment.sig>

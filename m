From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 14 Dec 2016 22:34:45 +0100
Subject: [PATCH] ARM: dts: n900: Mark eMMC slot with no-sdio and no-sd
 flags
In-Reply-To: <1481750984-11239-1-git-send-email-pali.rohar@gmail.com>
References: <1481750984-11239-1-git-send-email-pali.rohar@gmail.com>
Message-ID: <20161214213445.GD28424@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2016-12-14 22:29:44, Pali Roh?r wrote:
> Trying to initialize eMMC slot as SDIO or SD cause failure in n900 port of
> qemu. eMMC itself is not detected and is not working.
> 
> Real Nokia N900 harware does not have this problem. As eMMC is really not
> SDIO or SD based such change is harmless and will fix support for qemu.
> 
> Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161214/0c23d826/attachment.sig>

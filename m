From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 2 Nov 2018 23:16:27 +0100
Subject: [PATCH 02/15] Revert "platform/olpc: Make ec explicitly
 non-modular"
In-Reply-To: <20181010172300.317643-3-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-3-lkundrak@v3.sk>
Message-ID: <20181102221626.GC5322@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2018-10-10 19:22:47, Lubomir Rintel wrote:
> It doesn't make sense to always have this built-in, e.g. on ARM
> multiplatform kernels. A better way to address the problem the original
> commit aimed to solve is to fix Kconfig.
> 
> This reverts commit f48d1496b8537d75776478c6942dd87f34d7f270.

This looks ok, but I don't see the Kconfig fix in the series. Is it
needed?
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181102/e80fa70f/attachment.sig>

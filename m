From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 2 Nov 2018 23:16:57 +0100
Subject: [PATCH v2] DT: marvell,mmp2: add MMC controllers
In-Reply-To: <20180917110736.5948-1-lkundrak@v3.sk>
References: <20180917110736.5948-1-lkundrak@v3.sk>
Message-ID: <20181102221657.GF5322@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2018-09-17 13:07:36, Lubomir Rintel wrote:
> There's apparently four of them on a MMP2.
> 
> Changes since v1:
> - The controllers seem to be on AXI bus, not APB. Move them.
> - Remove aliases.
> 
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181102/75073bad/attachment.sig>

From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Jan 2013 21:07:55 +0000
Subject: [PATCH 15/15] staging/omapdrm: don't build on multiplatform
In-Reply-To: <50FED76B.10801@ti.com>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de>
 <201301221747.24618.arnd@arndb.de> <50FED76B.10801@ti.com>
Message-ID: <201301222107.55437.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 January 2013, Rob Clark wrote:
> I think it should be safe.. or at least it built fine for multi-plat in 
> the recent past and shouldn't really do anything if there is no omapdss 
> platform device.
> 
> Do you want me to make a patch or are you already doing this?

Please make one. Feel free to reuse my changeset description if needed.

	Arnd

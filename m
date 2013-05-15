From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 May 2013 16:20:56 +0200
Subject: [PATCH] arm: prima2: use of_platform_populate instead of
 of_platform_bus_probe
In-Reply-To: <1368523923-27137-1-git-send-email-Baohua.Song@csr.com>
References: <1368523923-27137-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <201305151620.56677.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 May 2013, Barry Song wrote:
> 
> use of_platform_populate to populate platform devices, it is suitable
> for creating devices which are children of the root node, then makes
> things like pcm work.
> 
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>

With 3.10-rc1 and above, you can just remove the sirfsoc_mach_init
function entirely for the same effect.

	Arnd

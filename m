From: albin.tonnerre@free-electrons.com (Albin Tonnerre)
Date: Thu, 11 Mar 2010 20:27:52 +0100
Subject: [PATCH v2] ARM: Add support for LZMA-compressed kernel images
In-Reply-To: <1268335467-24223-1-git-send-email-albin.tonnerre@free-electrons.com>
References: <1258729323-16318-1-git-send-email-albin.tonnerre@free-electrons.com>
	<1268335467-24223-1-git-send-email-albin.tonnerre@free-electrons.com>
Message-ID: <20100311192752.GI4585@pc-ran3241>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 11 Mar 2010 20:24 +0100, Albin Tonnerre wrote :
> This patch allows using a kernel image compressed with LZMA on ARM.
> Extracting the image is fairly slow, but it might be useful on machines
> with a very limited amount of storage, as the size benefit is quite
> significant:
> Gzip: Data Size:    1586352 Bytes = 1549.17 kB = 1.51 MB
> LZMA: Data Size:    2135916 Bytes = 2085.86 kB = 2.04 MB

Meh. That should of course be:
LZMA ... 1.51MB
Gzip ... 2.04MB
-- 
Albin Tonnerre, Free Electrons
Kernel, drivers and embedded Linux development,
consulting, training and support.
http://free-electrons.com

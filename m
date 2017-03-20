From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 20 Mar 2017 22:53:36 +0900
Subject: [PATCH 2/6] arm: Use full path in KBUILD_IMAGE definition
In-Reply-To: <20161122213434.14788-2-mmarek@suse.com>
References: <20161122213434.14788-1-mmarek@suse.com>
 <20161122213434.14788-2-mmarek@suse.com>
Message-ID: <CAK7LNASD-aW2084hhHM0N6jcLyRYJ1ZKQr9xtiuf4BUUuvGHHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-11-23 6:34 GMT+09:00 Michal Marek <mmarek@suse.com>:
> The KBUILD_IMAGE variable is used by the rpm and deb-pkg targets, which
> expect it to point to the image file in the build directory. The
> builddeb script has a workaround for architectures which only provide
> the basename, but let's provide a clean interface for packaging tools.
>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Michal Marek <mmarek@suse.com>



Applied to linux-kbuild/misc.  Thanks!


-- 
Best Regards
Masahiro Yamada

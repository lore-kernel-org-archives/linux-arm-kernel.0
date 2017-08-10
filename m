From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Aug 2017 12:58:45 +0200
Subject: [PATCH 6/6] arm64: uaccess: Implement *_flushcache variants
In-Reply-To: <a82a48f72b8099c1ef6a32a63819619637797ef8.1500397441.git.robin.murphy@arm.com>
References: <cover.1500397441.git.robin.murphy@arm.com>
 <a82a48f72b8099c1ef6a32a63819619637797ef8.1500397441.git.robin.murphy@arm.com>
Message-ID: <CAK8P3a1emRA_e_K+M-jRiXZD02nD38Vgn+V7R8NbSq0Wg=56Uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 12:55 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> Implement the set of copy functions with guarantees of a clean cache
> upon completion necessary to support the pmem driver.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  arch/arm64/Kconfig                  |  1 +
>  arch/arm64/include/asm/string.h     |  4 ++++
>  arch/arm64/include/asm/uaccess.h    | 12 ++++++++++
>  arch/arm64/lib/Makefile             |  2 ++
>  arch/arm64/lib/uaccess_flushcache.c | 47 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 66 insertions(+)
>  create mode 100644 arch/arm64/lib/uaccess_flushcache.c

It looks like Catalin applied part of this patch but forgot to add
arch/arm64/lib/uaccess_flushcache.c

      Arnd

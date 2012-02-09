From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 9 Feb 2012 10:58:04 -0800
Subject: [PATCH] ARM: EXYNOS: Adds Samsung TRATS board support
In-Reply-To: <1327652483-15655-1-git-send-email-riverful.kim@samsung.com>
References: <1324624169-16102-1-git-send-email-riverful.kim@samsung.com>
 <1327652483-15655-1-git-send-email-riverful.kim@samsung.com>
Message-ID: <CAJuYYwRn7Luhj0223-i9u3ETutb8qgFUY7FEBq-ZOUi74DouMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mr. HeungJun Kim,

On 27 January 2012 00:21, HeungJun, Kim <riverful.kim@samsung.com> wrote:
> This patch adds Samsung Mobile TRATS board support.
>
> Signed-off-by: HeungJun, Kim <riverful.kim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> ?arch/arm/mach-exynos/Kconfig ? ? ?| ? 11 ++
> ?arch/arm/mach-exynos/Makefile ? ? | ? ?1 +
> ?arch/arm/mach-exynos/mach-trats.c | ?344 +++++++++++++++++++++++++++++++++++++
> ?3 files changed, 356 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/mach-exynos/mach-trats.c

The exynos4 dt-enabled board file can support most of the features
added in this board file. The other option that could be considered
here would be to add DT support for this board file, and use AUX_DATA
to supply platform data for drivers that do not have dt support yet.
It would be better to use dt support for new board support that we
add.

Thanks,
Thomas.

(snip)

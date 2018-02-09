From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 8 Feb 2018 16:49:15 -0800
Subject: [PATCH -next] meson-mx-socinfo: Make local function
 meson_mx_socinfo_init() static
In-Reply-To: <1515593980-78559-1-git-send-email-weiyongjun1@huawei.com>
References: <1515593980-78559-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <CAOi56cXBqOrABbwwaf-S9_vvYFSRg4855QH4ZvE_ZPZ=nnsphg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 6:19 AM, Wei Yongjun <weiyongjun1@huawei.com> wrote:
> Fixes the following sparse warnings:
>
> drivers/soc/amlogic/meson-mx-socinfo.c:107:12: warning:
>  symbol 'meson_mx_socinfo_init' was not declared. Should it be static?
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied for v4.17,

Kevin

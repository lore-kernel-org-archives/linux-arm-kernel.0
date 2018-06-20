From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 20 Jun 2018 16:15:18 -0300
Subject: [PATCH v3 17/17] kasan: add SPDX-License-Identifier mark to
 source files
In-Reply-To: <f76d3070776e0038eda3cd76d471d1bfeae18480.1529515183.git.andreyknvl@google.com>
References: <cover.1529515183.git.andreyknvl@google.com>
 <f76d3070776e0038eda3cd76d471d1bfeae18480.1529515183.git.andreyknvl@google.com>
Message-ID: <CAOMZO5BgPaMsmx_3AJvMTKCFjhusfH=kH26U_PQCSD5TcUDA+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2018 at 2:40 PM, Andrey Konovalov <andreyknvl@google.com> wrote:

> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 6f4f2ebf5f57..3feacd889e24 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +// SPDX-License-Identifier: GPL-2.0

The original notation is correct: /* */ style is used for header files.

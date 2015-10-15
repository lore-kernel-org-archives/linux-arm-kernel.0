From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 15 Oct 2015 23:45:07 +0200
Subject: [PATCH 5/5] pinctrl: berlin: fix my family name spelling
In-Reply-To: <1444771901-24460-6-git-send-email-antoine.tenart@free-electrons.com>
References: <1444771901-24460-1-git-send-email-antoine.tenart@free-electrons.com>
 <1444771901-24460-6-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <56201E63.4000500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.10.2015 23:31, Antoine Tenart wrote:
> My family name contained an accent when I submitted the
> Berlin pinctrl series in the first place. There was an
> encoding issue when the series was applied. Fix this.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

and sorry for the non-UTF-8 mess.

Sebastian

> ---
>   drivers/pinctrl/berlin/berlin-bg2.c   | 4 ++--
>   drivers/pinctrl/berlin/berlin-bg2cd.c | 4 ++--
>   drivers/pinctrl/berlin/berlin-bg2q.c  | 4 ++--
>   drivers/pinctrl/berlin/berlin.c       | 2 +-
>   drivers/pinctrl/berlin/berlin.h       | 2 +-
>   5 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pinctrl/berlin/berlin-bg2.c b/drivers/pinctrl/berlin/berlin-bg2.c
> index 274c5535b531..cfbf22a496ca 100644
> --- a/drivers/pinctrl/berlin/berlin-bg2.c
> +++ b/drivers/pinctrl/berlin/berlin-bg2.c
> @@ -3,7 +3,7 @@
>    *
>    * Copyright (C) 2014 Marvell Technology Group Ltd.
>    *
> - * Antoine T??nart <antoine.tenart@free-electrons.com>
> + * Antoine Tenart <antoine.tenart@free-electrons.com>
>    *
>    * This file is licensed under the terms of the GNU General Public
>    * License version 2. This program is licensed "as is" without any
> @@ -246,6 +246,6 @@ static struct platform_driver berlin2_pinctrl_driver = {
>   };
>   module_platform_driver(berlin2_pinctrl_driver);
>
> -MODULE_AUTHOR("Antoine T??nart <antoine.tenart@free-electrons.com>");
> +MODULE_AUTHOR("Antoine Tenart <antoine.tenart@free-electrons.com>");
>   MODULE_DESCRIPTION("Marvell Berlin BG2 pinctrl driver");
>   MODULE_LICENSE("GPL");
> diff --git a/drivers/pinctrl/berlin/berlin-bg2cd.c b/drivers/pinctrl/berlin/berlin-bg2cd.c
> index 0cb793a3552a..77f4f30cc686 100644
> --- a/drivers/pinctrl/berlin/berlin-bg2cd.c
> +++ b/drivers/pinctrl/berlin/berlin-bg2cd.c
> @@ -3,7 +3,7 @@
>    *
>    * Copyright (C) 2014 Marvell Technology Group Ltd.
>    *
> - * Antoine T??nart <antoine.tenart@free-electrons.com>
> + * Antoine Tenart <antoine.tenart@free-electrons.com>
>    *
>    * This file is licensed under the terms of the GNU General Public
>    * License version 2. This program is licensed "as is" without any
> @@ -189,6 +189,6 @@ static struct platform_driver berlin2cd_pinctrl_driver = {
>   };
>   module_platform_driver(berlin2cd_pinctrl_driver);
>
> -MODULE_AUTHOR("Antoine T??nart <antoine.tenart@free-electrons.com>");
> +MODULE_AUTHOR("Antoine Tenart <antoine.tenart@free-electrons.com>");
>   MODULE_DESCRIPTION("Marvell Berlin BG2CD pinctrl driver");
>   MODULE_LICENSE("GPL");
> diff --git a/drivers/pinctrl/berlin/berlin-bg2q.c b/drivers/pinctrl/berlin/berlin-bg2q.c
> index a466054a8206..66fffe6fab8d 100644
> --- a/drivers/pinctrl/berlin/berlin-bg2q.c
> +++ b/drivers/pinctrl/berlin/berlin-bg2q.c
> @@ -3,7 +3,7 @@
>    *
>    * Copyright (C) 2014 Marvell Technology Group Ltd.
>    *
> - * Antoine T??nart <antoine.tenart@free-electrons.com>
> + * Antoine Tenart <antoine.tenart@free-electrons.com>
>    *
>    * This file is licensed under the terms of the GNU General Public
>    * License version 2. This program is licensed "as is" without any
> @@ -408,6 +408,6 @@ static struct platform_driver berlin2q_pinctrl_driver = {
>   };
>   module_platform_driver(berlin2q_pinctrl_driver);
>
> -MODULE_AUTHOR("Antoine T??nart <antoine.tenart@free-electrons.com>");
> +MODULE_AUTHOR("Antoine Tenart <antoine.tenart@free-electrons.com>");
>   MODULE_DESCRIPTION("Marvell Berlin BG2Q pinctrl driver");
>   MODULE_LICENSE("GPL");
> diff --git a/drivers/pinctrl/berlin/berlin.c b/drivers/pinctrl/berlin/berlin.c
> index f49580617055..ebd6f78a6dde 100644
> --- a/drivers/pinctrl/berlin/berlin.c
> +++ b/drivers/pinctrl/berlin/berlin.c
> @@ -3,7 +3,7 @@
>    *
>    * Copyright (C) 2014 Marvell Technology Group Ltd.
>    *
> - * Antoine T??nart <antoine.tenart@free-electrons.com>
> + * Antoine Tenart <antoine.tenart@free-electrons.com>
>    *
>    * This file is licensed under the terms of the GNU General Public
>    * License version 2. This program is licensed "as is" without any
> diff --git a/drivers/pinctrl/berlin/berlin.h b/drivers/pinctrl/berlin/berlin.h
> index e1aa84145194..94495d304005 100644
> --- a/drivers/pinctrl/berlin/berlin.h
> +++ b/drivers/pinctrl/berlin/berlin.h
> @@ -3,7 +3,7 @@
>    *
>    * Copyright (C) 2014 Marvell Technology Group Ltd.
>    *
> - * Antoine T??nart <antoine.tenart@free-electrons.com>
> + * Antoine Tenart <antoine.tenart@free-electrons.com>
>    *
>    * This file is licensed under the terms of the GNU General Public
>    * License version 2. This program is licensed "as is" without any
>

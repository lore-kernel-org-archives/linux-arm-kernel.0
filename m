From: zonque@gmail.com (Daniel Mack)
Date: Wed, 11 Dec 2013 14:16:33 +0100
Subject: [PATCH 0/8] Impedance matcher for Samsung boards
In-Reply-To: <1386767259-15693-1-git-send-email-p.wilczek@samsung.com>
References: <1386767259-15693-1-git-send-email-p.wilczek@samsung.com>
Message-ID: <52A865B1.9070908@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2013 02:07 PM, Piotr Wilczek wrote:
> This patchset implements the impedance-matcher for Samsung Exynos boards
> and does the following:
>  - fix strncmp function;
>  - ensure each DT blob is 4-byte aligned;
>  - port 'atags_to_fdt' form Kernel;
>  - add Exynos specific serial driver;
>  - add support for Samsung boards, Trats and Trats2;
> 
> This patch set is based on:
> https://github.com/zonque/pxa-impedance-matcher.git

Thanks for the patches!

I'm considering merging most of them, but I have my problems with the
inclusion of the libfdt library.

Could you explain what you need this for, exactly? Why can't you just
fix the device tree blob that you include instead of modifying it at
runtime?


Daniel

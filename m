From: sunder.svit@gmail.com (Sundar)
Date: Thu, 2 Dec 2010 23:44:32 +0530
Subject: [PATCH v2] ARM: ux500: prcmu db8500 v2 support
In-Reply-To: <1291303242-27000-1-git-send-email-mattias.wallin@stericsson.com>
References: <1291303242-27000-1-git-send-email-mattias.wallin@stericsson.com>
Message-ID: <AANLkTik+ZhUomjD5QmKrU5vWE-H9Gt+4sbGYUWSzkQ-q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 2, 2010 at 8:50 PM, Mattias Wallin
<mattias.wallin@stericsson.com> wrote:
> This patch adds support for db8500 chip version 2.
>
> ? ? ? ?if (cpu_is_u8500ed())
> - ? ? ? ? ? ? ? iotable_init(u8500ed_io_desc, ARRAY_SIZE(u8500ed_io_desc));

Now that the ED support is deprecated, why still play around with these?

> + ? ? ? if (cpu_is_u8500v11() || cpu_is_u8500ed()) {
> + ? ? ? ? ? ? ? tcdm_base = __io_address(U8500_PRCMU_TCDM_BASE_V1);

Same here..

Cheers!
-- 
---------
The views expressed in this email are my personal ones and do not
necessarily echo my employers.

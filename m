From: rafael@kernel.org (Rafael J. Wysocki)
Date: Sat, 13 Feb 2016 00:07:00 +0100
Subject: [PATCH v2 3/9] ACPI: introduce acpi_table_parse2()
In-Reply-To: <1455299022-11641-4-git-send-email-aleksey.makarov@linaro.org>
References: <1455299022-11641-1-git-send-email-aleksey.makarov@linaro.org>
 <1455299022-11641-4-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <CAJZ5v0i2RCEEZwCN+Ran3Qmasn4yEk1rbfWkZ5QbEkUQWvaJ+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2016 at 6:43 PM, Aleksey Makarov
<aleksey.makarov@linaro.org> wrote:
> The function acpi_table_parse() has some problems:
> 1 It can be called only from __init code
> 2 It does not pass any data to the handler
> 3 It just throws out the value returned from the handler

So why are those problems?

> These issues are addressed in this patch

How are they addressed?

Thanks,
Rafael

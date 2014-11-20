From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 13:19:15 +0100
Subject: [GIT PULL 1/3] soc: few non crtical fixes for 3.19
In-Reply-To: <1415843982-5739-1-git-send-email-ssantosh@kernel.org>
References: <1415843982-5739-1-git-send-email-ssantosh@kernel.org>
Message-ID: <201411201319.15250.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 November 2014, Santosh Shilimkar wrote:
> Keystone SOC Navigator driver non critical fixes frm Alex for 3.19
> 
>         - Use list_for_each_entry_safe to prevent use after free
>         - Return proper error if devm_kzalloc fails
>         - Use list_first_entry_or_null() at appropriate places

Pulled into next/drivers, as this isn't in the normal arm-soc territory.

Thanks,

	Arnd

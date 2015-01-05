From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Jan 2015 08:25:54 -0800
Subject: [PATCH v11 6/9] ARM: l2c: Add support for overriding prefetch
 settings
In-Reply-To: <1420460348-20302-7-git-send-email-m.szyprowski@samsung.com>
References: <1420460348-20302-1-git-send-email-m.szyprowski@samsung.com>
 <1420460348-20302-7-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20150105162553.GF4081@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marek Szyprowski <m.szyprowski@samsung.com> [150105 04:22]:
> From: Tomasz Figa <t.figa@samsung.com>
> 
> Firmware on certain boards (e.g. ODROID-U3) can leave incorrect L2C prefetch
> settings configured in registers leading to crashes if L2C is enabled
> without overriding them. This patch introduces bindings to enable
> prefetch settings to be specified from DT and necessary support in the
> driver.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> [mszyprow: rebased onto v3.18-rc1, added error message when prefetch related
>  dt property has been provided without any value]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Acked-by: Tony Lindgren <tony@atomide.com>

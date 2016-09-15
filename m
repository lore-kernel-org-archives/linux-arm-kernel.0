From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Sep 2016 13:28:31 +0200
Subject: [PATCH 1/7] mfd: max8997-irq: 'inline' should be at the beginning
 of the declaration
In-Reply-To: <20160915104521.14286-2-lee.jones@linaro.org>
References: <20160915104521.14286-1-lee.jones@linaro.org>
 <20160915104521.14286-2-lee.jones@linaro.org>
Message-ID: <6210143.TgbX7tJ4uj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 15, 2016 11:45:15 AM CEST Lee Jones wrote:
> -static const inline struct max8997_irq_data *
> +inline static const struct max8997_irq_data *

I think this causes another warning, the order should be
"stastic inline const struct max8997_irq_data".

	Arnd

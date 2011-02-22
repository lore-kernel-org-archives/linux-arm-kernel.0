From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Feb 2011 07:31:20 -0800
Subject: [PATCH 1/6] ARM: tegra: add tegra_gpio_table and tegra_gpio_config
In-Reply-To: <4D63B661.6000407@ru.mvista.com>
References: <1298354117-19097-1-git-send-email-olof@lixom.net>
	<1298354117-19097-2-git-send-email-olof@lixom.net>
	<4D63B661.6000407@ru.mvista.com>
Message-ID: <AANLkTi=y88Ju+0=2WJJO_5fpq-RP+kPRHeWiYBrjCDQ0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 22, 2011 at 5:13 AM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:

>> +void __init tegra_gpio_config(struct tegra_gpio_table *table, int num);
>
> ? You don't need to annotate the declaration as __init.

D'oh. Fixed. Thanks.


-Olof

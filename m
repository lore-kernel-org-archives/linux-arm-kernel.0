From: jeffy.chen@rock-chips.com (jeffy)
Date: Sat, 14 Oct 2017 02:12:41 +0800
Subject: [RESEND PATCH 2/2] arm64: dts: rockchip: Enable edp disaplay
 on kevin
In-Reply-To: <3037285.0MAZvLKA4I@phil>
References: <20171013104138.3216-1-jeffy.chen@rock-chips.com>
 <20171013104138.3216-3-jeffy.chen@rock-chips.com> <3037285.0MAZvLKA4I@phil>
Message-ID: <59E10219.3060009@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi heiko,

On 10/13/2017 09:25 PM, Heiko Stuebner wrote:
> does this actually work with mainline kernel sources?
>
> Sean Paul did look at making the edp work on Chromebooks recently,
> but it seemed there were still parts missing to make it actually display
> something.

yes, it works, but only for boot-splash(boot animation). we still need 
mali gru stuff to bring chrome browser up...i think caesar tried that 
before(but i don't think he would submit that)
>
>
> Heiko

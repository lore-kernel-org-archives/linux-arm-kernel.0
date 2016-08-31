From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 31 Aug 2016 20:43:15 +0300
Subject: [PATCH] rtc: constify rtc_class_ops structures
In-Reply-To: <1472630725-25465-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1472630725-25465-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20160831174315.4djfepwsrxmuhp56@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julia,

On Wed, Aug 31, 2016 at 10:05:25AM +0200, Julia Lawall wrote:
> Check for rtc_class_ops structures that are only passed to
> devm_rtc_device_register, rtc_device_register,
> platform_device_register_data, all of which declare the corresponding
> parameter as const.  Declare rtc_class_ops structures that have these
> properties as const.

[...]

> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

For rtc-digicolor.c:

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

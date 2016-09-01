From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Thu, 1 Sep 2016 12:21:26 +0200 (CEST)
Subject: [PATCH] rtc: constify rtc_class_ops structures
In-Reply-To: <1472630725-25465-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1472630725-25465-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <alpine.LNX.2.00.1609011219330.31401@T520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julia 

On Wed, 31 Aug 2016, Julia Lawall wrote:

> Check for rtc_class_ops structures that are only passed to
> devm_rtc_device_register, rtc_device_register,
> platform_device_register_data, all of which declare the corresponding
> parameter as const.  Declare rtc_class_ops structures that have these
> properties as const.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 

> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

for drivers/rtc/rtc-gemini.c

Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>

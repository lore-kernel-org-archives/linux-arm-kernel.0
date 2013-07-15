From: julien.grall@linaro.org (Julien Grall)
Date: Mon, 15 Jul 2013 16:49:32 +0100
Subject: [Xen-devel] [PATCH] xen/control: protect functions with
 CONFIG_HIBERNATE_CALLBACKS to avoid warning
In-Reply-To: <51E41975.3070706@citrix.com>
References: <1373898275-15765-1-git-send-email-julien.grall@linaro.org>
 <20130715152714.GD5774@phenom.dumpdata.com> <51E41975.3070706@citrix.com>
Message-ID: <51E41A0C.2050408@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Forgot the different cc.

On 07/15/2013 04:47 PM, Julien Grall wrote:
> On 07/15/2013 04:27 PM, Konrad Rzeszutek Wilk wrote:
>> On Mon, Jul 15, 2013 at 03:24:35PM +0100, Julien Grall wrote:
>>> If CONFIG_HIBERNATE_CALLBACKS is not set gcc will issue warnings:
>>> drivers/xen/manage.c:46:13: warning: 'xen_hvm_post_suspend' defined but not used [-Wunused-function]
>>> drivers/xen/manage.c:52:13: warning: 'xen_pre_suspend' defined but not used [-Wunused-function]
>>> drivers/xen/manage.c:59:13: warning: 'xen_post_suspend' defined but not used [-Wunused-function]
>>
>> Have you checked the upstream kernel?
> 
> My apologies, I forgot to check upstream for this patch.
> 

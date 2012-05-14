From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 14 May 2012 09:45:16 +0100
Subject: [PATCH 11/15] drivers/mfd: Enable Device Tree for ab8500-core
 driver
In-Reply-To: <20120511101233.GH1214@sortiz-mobl>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-12-git-send-email-lee.jones@linaro.org>
 <20120511101233.GH1214@sortiz-mobl>
Message-ID: <4FB0C61C.9020509@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sam,

> On Fri, May 04, 2012 at 07:23:21PM +0100, Lee Jones wrote:
>> This patch will allow the ab8500-core driver to be probed and set up
>> when booting when Device Tree is enabled. This includes platform ID
>> look-up which identifies the machine it is currently running on. If
>> we are undergoing a DT enabled boot, we will refuse to setup each of
>> the other ab8500-* devices, as they will be probed individually by DT.
> This one doesn't apply to my for-next branch. Which tree/branch did you use to
> generate it ?

I've been using the latest Mainline -rc, but one of my first jobs today 
is to rebase this patch-set against -next and resubmit.

Sorry for any confusion caused.

Kind regards,
Lee

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

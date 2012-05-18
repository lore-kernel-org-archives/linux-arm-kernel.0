From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 May 2012 08:52:48 +0100
Subject: [PATCH 11/18] regulator: Enable the ab8500 for Device Tree
In-Reply-To: <20120518073648.GD4073@opensource.wolfsonmicro.com>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
 <1337262323-27692-12-git-send-email-lee.jones@linaro.org>
 <20120518073648.GD4073@opensource.wolfsonmicro.com>
Message-ID: <4FB5FFD0.4050708@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/05/12 08:36, Mark Brown wrote:
> On Thu, May 17, 2012 at 02:45:16PM +0100, Lee Jones wrote:
>> Here we setup the ab8500 regulator driver for DT. We first do
>> this in the normal way, by providing a match structure during
>> initialisation, but then we provide information so that
>> whilst probing we can use existing data structures to do DT
>> look-ups.
>
> Applied, thanks.  This and your previous patch look really good now!

Cheers Mark. Much obliged.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

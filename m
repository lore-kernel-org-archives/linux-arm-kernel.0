From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 20 Jun 2012 14:19:00 +0100
Subject: [PATCH 08/15] regulator: Stop initialising AB8500's registers
 during bring-up
In-Reply-To: <20120620130840.GM3978@opensource.wolfsonmicro.com>
References: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
 <1340197011-5435-9-git-send-email-lee.jones@linaro.org>
 <20120620130840.GM3978@opensource.wolfsonmicro.com>
Message-ID: <4FE1CDC4.9000305@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/06/12 14:08, Mark Brown wrote:
> On Wed, Jun 20, 2012 at 01:56:44PM +0100, Lee Jones wrote:
>> There is no need to initialise the AB8500's regulator registers, as
>> most of this work is already carried out by framework features.
>
> Does this have any dependency on the rest of the series?

Unfortunately yes.

It needs the "ARM: ux500:" stuff to go in first.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

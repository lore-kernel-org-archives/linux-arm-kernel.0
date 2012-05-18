From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 May 2012 08:53:05 +0100
Subject: [PATCH 09/18] regulator: ab8500: Split up probe() into manageable
 pieces
In-Reply-To: <20120518073603.GC4073@opensource.wolfsonmicro.com>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
 <1337262323-27692-10-git-send-email-lee.jones@linaro.org>
 <20120518073603.GC4073@opensource.wolfsonmicro.com>
Message-ID: <4FB5FFE1.9030204@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/05/12 08:36, Mark Brown wrote:
> On Thu, May 17, 2012 at 02:45:14PM +0100, Lee Jones wrote:
>> ab8500's probe() function is becoming quite large, so in the lead
>> up to Device Tree enablement which will fork the thread of execution
>> this patch splits it into 3 main areas; basic error checking will
>> remain in probe(), but regulator register initialisation and regulator
>> registration have been moved to their own functions which will
>> be called in sequence by probe() and the DT equivalent.
>
> Applied, thanks.

Thank you.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 30 Jul 2012 17:32:10 +0100
Subject: AB8500 Regulators
In-Reply-To: <20120730152618.GI4468@opensource.wolfsonmicro.com>
References: <501690F7.2010904@linaro.org>
 <20120730152618.GI4468@opensource.wolfsonmicro.com>
Message-ID: <5016B70A.1030601@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/07/12 16:26, Mark Brown wrote:
> On Mon, Jul 30, 2012 at 02:49:43PM +0100, Lee Jones wrote:
>
>> I wrote a patch which pulled each of these initial values into
>> Device Tree, but you NACK:ed it believing that most of the options
>> could be dealt with using the API. There is currently no API to set
>> up ST-Ericsson's configuration. So what's the best thing to do? How
>> do all of the other regulator drivers deal with non-standard
>> configuration? Or is it unheard of to use non-standard start-up
>> values?
>
> Well, a good start would be to work out what those register writes
> actually do and then we can have a discussion on how to do whatever
> that is.

Most of the configuration seems to pertain to voltage selection and 
making regulators valid. I assume this means you can enable them via 
their own registers and the enablement will take hold. This seems like 
pretty routine stuff as far as regulator configuration goes.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

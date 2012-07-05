From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 05 Jul 2012 16:51:33 +0100
Subject: [PATCH 1/1] mfd: Fix runtime warning caused by duplicate device
 registration
In-Reply-To: <201207051541.52261.arnd@arndb.de>
References: <20120703132447.GN29030@opensource.wolfsonmicro.com>
 <20120705141329.GN4111@opensource.wolfsonmicro.com>
 <4FF5A61F.2050400@linaro.org> <201207051541.52261.arnd@arndb.de>
Message-ID: <4FF5B805.8000205@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/12 16:41, Arnd Bergmann wrote:
> On Thursday 05 July 2012, Lee Jones wrote:
>>
>> On 05/07/12 15:13, Mark Brown wrote:
>>> On Thu, Jul 05, 2012 at 03:06:20PM +0100, Lee Jones wrote:
>>>> On 05/07/12 14:57, Arnd Bergmann wrote:
>>>
>>>>> The non-DT path for this is a huge mess, I'd rather focus on making
>>>>> it obsolete than trying to fix it. Other than that, I agree that
>>>>> we should be registering the ab8500 from the prcmu from both the
>>>>> DT and the non-DT case.
>>>
>>>> Ah, is that what you were saying Mark?
>>>
>>>> If so, I apologise. I thought you meant register both from platform
>>>> code. I'm happy to register the AB8500 from the DB8500 for both DT
>>>> and !DT.
>>>
>>> Yes, that's what I was trying to say - sorry that I wasn't clear!
>>
>> Well it seems silly of me just to copy Arnd's work. Do you want to
>> author and submit the patch to do this Arnd?
>
> No, just assume ownership of it. I haven't tried building the
> patch, so I assume you will have to change it some more. Just
> list me as Suggested-by:.

It'll have to wait until tomorrow now, but okay, I'll take it on.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

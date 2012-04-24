From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 24 Apr 2012 08:59:49 +0100
Subject: [PATCH 09/15] ARM: ux500: Correctly describe SMSC9115 for Snowball
 in DT
In-Reply-To: <CACRpkda7HJ-58gPxiZARvybsV1PByLHF0hZ2yzVQ4iFR7pwy_A@mail.gmail.com>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <1334867804-31942-10-git-send-email-lee.jones@linaro.org>
 <CACRpkda7HJ-58gPxiZARvybsV1PByLHF0hZ2yzVQ4iFR7pwy_A@mail.gmail.com>
Message-ID: <4F965D75.3000704@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/04/12 08:54, Linus Walleij wrote:
> On Thu, Apr 19, 2012 at 10:36 PM, Lee Jones<lee.jones@linaro.org>  wrote:
>
>> Here we split the description of the external-bus at 50000000 over
>> two description files. In the more generic db8500 description file
>> we only specify the external-bus. Normally this would be used to
>> communicate with a NOR-flash device. On the Snowball however, the
>> SMSC9115 Ethernet chip occupies it. In the Snowball board specific
>> description file is where we actually specify that it is in fact the
>> Ethernet device which lives here.
>>
>> Signed-off-by: Lee Jones<lee.jones@linaro.org>
>
> Can you please squash this into patch 7?
>
> It seems like I get a bit more development history than I need
> here.

Sure.


-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

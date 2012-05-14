From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 14 May 2012 21:38:27 +0100
Subject: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
In-Reply-To: <20120514180619.GH25668@opensource.wolfsonmicro.com>
References: <CAF2Aj3gHaha9mO4gKf0ReQc-wR7wpomf_9m59AfAUNBr2fLyCQ@mail.gmail.com>
 <20120514180619.GH25668@opensource.wolfsonmicro.com>
Message-ID: <4FB16D43.2040301@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/05/12 19:06, Mark Brown wrote:
> On Mon, May 14, 2012 at 06:39:00PM +0100, Lee Jones wrote:
>
>> Okay, so can you suggest a way to marry up the constraints found in DT to
>> the remainder of the settings found in the driver without pointlessly
>> applying it all to the DT itself (which is was some of the other drives
>> have done)?
>
> That's what people are using regulator_of_match() for - it's for mapping
> the init data in DT array to a handle the driver can use for its
> internal data (and vice versa).  See how tps65910 is using it for an
> example.

Ah, I see it now. Looks like that's what I'm after.

I'll sort it out and try to get the new patch off tomorrow.

Thanks Mark.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

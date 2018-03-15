From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Thu, 15 Mar 2018 07:12:34 -0700
Subject: [PATCH v2 1/2] soc: imx: gpcv2: Do not pass static memory as
 platform data
In-Reply-To: <20180315135225.GK26859@dragon>
References: <20180122150748.1742-1-andrew.smirnov@gmail.com>
 <20180208064709.GB31910@dragon> <20180315030804.GI26859@dragon>
 <CAHQ1cqHdtN7xjmAcQvKDknnGKAP0pRgk6pcFrzOiSew9=Z9GQg@mail.gmail.com>
 <20180315135225.GK26859@dragon>
Message-ID: <CAHQ1cqGh0gmgCcFmc-sx7FzumnsObgzJTWm40ExuVo_o8EwCZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 6:52 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Thu, Mar 15, 2018 at 06:00:06AM -0700, Andrey Smirnov wrote:
>> I am slightly confused by your phrasing. Are you:
>>
>> a) saying that you dropped my patches in favor of your own that use
>> platform_device_add_data()
>>
>> or
>>
>> b) asking me to convert my patches to use platform_device_add_data()?
>>
>> Just trying to figure out if any action on my part is necessary.
>
> Sorry for the blur.  I'm asking you to repost your patches with using
> platform_device_add_data().  In other word, that's b).

OK, cool, will do.

Thanks,
Andrey Smirnov

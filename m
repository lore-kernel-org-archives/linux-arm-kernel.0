From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 10 Feb 2011 10:21:12 +0800
Subject: ARM: mmp: add Trizeps6 board support
In-Reply-To: <42563.88.65.119.194.1297298342.squirrel@88.65.119.194>
References: <42563.88.65.119.194.1297298342.squirrel@88.65.119.194>
Message-ID: <AANLkTi=AMOifp3nQqohk5fW0JTWPp7VNRgutp0h7bBxH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 10, 2011 at 8:39 AM, Yupeng Schneider
<yupeng.schneider@ipms.fraunhofer.de> wrote:
> Hello Eric,
>
> i have made a BSP for the Trizeps6 Modul based on pxa168 Processor. Here
> is just a part of it, which now could be published, the other part could
> not because of NDA. Now i have a question:
>
> The Trizeps6 uses the same baseboard (ConXS) as the Trizeps4. Where would
> u to place the file conxs.c to make it accessible for mach-pxa und
> mach-mmp?
>

I would recommend arch/arm/plat-pxa/ or arch/arm/common/ at this moment.

> yours,
> Y.
>
>
>
>
>
>
>

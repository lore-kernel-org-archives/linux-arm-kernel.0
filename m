From: rmallon@gmail.com (Ryan Mallon)
Date: Mon, 04 Jun 2012 15:52:13 +1000
Subject: Request for inclusion of ep93xx tree in linux-next
In-Reply-To: <4F9F16A9.9090108@gmail.com>
References: <4F9F16A9.9090108@gmail.com>
Message-ID: <4FCC4D0D.8000504@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

I have ended up adding another branch to my ep93xx tree, so I have
created an ep93xx-for-next branch, which I will just merge all of
branches into. Can you please drop the ep93xx-cleanup and ep93xx-fixes
branches and just include ep93xx-for-next instead.

Thanks,
~Ryan

On 01/05/12 08:48, Ryan Mallon wrote:

> Hi Stephen,
> 
> Can you please add the following branches:
> 
>   ep93xx-cleanup
>   ep93xx-fixes
> 
> from the ep93xx git tree:
> 
>   git://github.com/RyanMallon/linux-ep93xx.git
> 
> To linux-next. Both branches are stable and based on v3.4-rc2. Testing
> for the tree is covered by the arm ep93xx_defconfig.
> 
> Thanks,
> ~Ryan

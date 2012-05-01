From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 1 May 2012 08:36:28 +0000
Subject: Request for inclusion of ep93xx tree in linux-next
In-Reply-To: <4F9F16A9.9090108@gmail.com>
References: <4F9F16A9.9090108@gmail.com>
Message-ID: <201205010836.28365.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 April 2012, Ryan Mallon wrote:
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

Hi Ryan,

just for your convenience, it helps if you have only one branch that
you get included into linux-next and that combines various branches
which you intend to send to arm-soc. That frees you from the need to
notify Stephen every time you want to have another branch included.

	Arnd

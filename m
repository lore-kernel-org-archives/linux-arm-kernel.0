From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Oct 2015 16:10:45 +0200
Subject: linux-next: build failure after merge of the arm-soc tree
In-Reply-To: <20151015101920.7fa592f7@canb.auug.org.au>
References: <20151015101920.7fa592f7@canb.auug.org.au>
Message-ID: <364744228.v8zmI08FKn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 October 2015 10:19:20 Stephen Rothwell wrote:
> 
> After merging the arm-soc tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> arch/arm/boot/dts/berlin2q.dtsi:62.24-25 syntax error
> FATAL ERROR: Unable to parse input tree
> 
> I can't see what caused this error, so I have just used the arm-soc tree
> from next-20151013 for today.
> 
> 

Thanks a lot, I've merged a broken branch that was based on the
wrong start point.

	Arnd

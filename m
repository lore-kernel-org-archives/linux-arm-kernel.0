From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Mar 2016 12:21:07 +0100
Subject: [PATCH] ARM: use --fix-v4bx to allow building ARMv4 with future
 gcc
In-Reply-To: <20160317104645.GZ19428@n2100.arm.linux.org.uk>
References: <12678426.5oeMNXL25J@wuerfel>
 <20160317104645.GZ19428@n2100.arm.linux.org.uk>
Message-ID: <2066491.QlhNIVNMMC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 March 2016 10:46:45 Russell King - ARM Linux wrote:
> > instructions instead of 'ld pc,reg'. This is not supported on
> 
> ITYM mov pc, reg
> 
> > in loadable modules and converts bx instructions into ldr even
> 
> MOV.
> 

Fixed, thanks.

	Arnd

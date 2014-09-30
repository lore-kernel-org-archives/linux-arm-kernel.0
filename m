From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Sep 2014 17:15:19 +0200
Subject: [PATCH] of/pci: add pci_pio_to_address dummy for !CONFIG_OF
In-Reply-To: <20140930144506.GQ841@e106497-lin.cambridge.arm.com>
References: <706416181.hbVGLDA3o6@wuerfel>
 <20140930144506.GQ841@e106497-lin.cambridge.arm.com>
Message-ID: <2033939.5UfzeSiRKs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 September 2014 15:45:06 Liviu Dudau wrote:
> 
> Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>
> 
> Is that triggered by shmobile_defconfig?
> 
> 

No, I only found it using randconfig testing, shmobile enables CONFIG_OF by
default.

	Arnd

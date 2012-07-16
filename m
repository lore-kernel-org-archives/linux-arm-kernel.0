From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Jul 2012 09:18:33 +0000
Subject: [PATCH 2/3] ARM: use asm-generic version of kmap_types.h
In-Reply-To: <1342410836-6010-3-git-send-email-robherring2@gmail.com>
References: <1342410836-6010-1-git-send-email-robherring2@gmail.com>
 <1342410836-6010-3-git-send-email-robherring2@gmail.com>
Message-ID: <201207160918.33856.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 July 2012, Rob Herring wrote:
> 
> From: Rob Herring <rob.herring@calxeda.com>
> 
> kmap_types.h is virtually unused now with the stack based kmap_atomic,
> so we can just use the generic one. This does bump KM_TYPE_NR from 16
> to 20, but there is still plenty of space left in the fixmap area.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---

I would suggest you drop this one. There is a series for removing
kmap_types.h on all architectures already, so let's avoid the conflict.

	Arnd

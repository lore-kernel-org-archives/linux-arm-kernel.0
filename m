From: olof@lixom.net (Olof Johansson)
Date: Thu, 1 Jun 2017 16:52:51 -0700
Subject: [PATCH] ARM: dts: versatile: use #include "..." to include local
 DT
In-Reply-To: <1495602610-18667-1-git-send-email-yamada.masahiro@socionext.com>
References: <1495602610-18667-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20170601235251.GB13314@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 02:10:10PM +0900, Masahiro Yamada wrote:
> Most of DT files in ARM use #include "..." to make pre-processor
> include DT in the same directory, but this is one of the exceptional
> files that use #include <...> for that.
> 
> Fix it to remove -I$(srctree)/arch/$(SRCARCH)/boot/dts path from
> dtc_cpp_flags.
> 
> ARM: dts: versatile: use #include "..." to include DT in the same directory
> 
> Most of DT files in ARM use #include "..." to make pre-processor
> include DT in the same directory, but we have 3 exceptional files
> that use #include <...> for that.
> 
> They must be fixed to remove -I$(srctree)/arch/$(SRCARCH)/boot/dts
> path from dtc_cpp_flags.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Arnd, Olof,
> I could not find a sub-arch maintainer for versatile.
> If nobody picks up this, could you take care of this?

Applied to fixes. Thanks!


-Olof

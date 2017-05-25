From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 25 May 2017 09:27:47 +0800
Subject: [PATCH] ARM: dts: imx6: use #include "..." to include local DT
In-Reply-To: <1495602162-14672-1-git-send-email-yamada.masahiro@socionext.com>
References: <1495602162-14672-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20170525012745.GQ26102@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 02:02:42PM +0900, Masahiro Yamada wrote:
> Most of DT files in ARM use #include "..." to make pre-processor
> include DT in the same directory, but we have some exceptional files
> that use #include <...> for that.
> 
> Fix them to remove -I$(srctree)/arch/$(SRCARCH)/boot/dts path from
> dtc_cpp_flags.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied, thanks.

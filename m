From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Jun 2016 12:13:40 -0700
Subject: [PATCH] arm64: dts: drop "arm, amba-bus" in favor of "simple-bus"
 part 2
In-Reply-To: <1464574353-31477-1-git-send-email-yamada.masahiro@socionext.com>
References: <1464574353-31477-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160603191340.GA3761@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2016 at 11:12:33AM +0900, Masahiro Yamada wrote:
> Tree-wide replacement was done by commit 2ef7d5f342c1 (ARM, ARM64:
> dts: drop "arm,amba-bus" in favor of "simple-bus"), but we have some
> new users of "arm,amba-bus" at Linux 4.7-rc1.  Eliminate them now.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> In order to not leave these compatible strings for the release,
> is it OK to apply this patch for Linux 4.7 ?

Thanks, applied to fixes.


-Olof

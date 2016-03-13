From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 Mar 2016 17:40:53 -0800
Subject: [PATCH v3] ARM, ARM64: dts: drop "arm, amba-bus" in favor of
 "simple-bus"
In-Reply-To: <1457497605-10079-1-git-send-email-yamada.masahiro@socionext.com>
References: <1457497605-10079-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160313014053.GF5883@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2016 at 01:26:45PM +0900, Masahiro Yamada wrote:
> The compatible string "simple-bus" is well defined in ePAPR, while
> I see no documentation for the "arm,amba-bus" arnywhere in ePAPR or
> Documentation/devicetree/.
> 
> DT is also used by other projects than Linux kernel.  It is not a
> good idea to rely on such an unofficial binding.
> 
> This commit
>   - replaces "arm,amba-bus" with "simple-bus"
>   - drops "arm,amba-bus" where it is used along with "simple-bus"
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Thanks, applied.


-Olof

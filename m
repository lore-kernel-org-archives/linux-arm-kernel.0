From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Jun 2016 12:23:45 -0700
Subject: [PATCH v2] ARM: uniphier: drop code for old DT binding
In-Reply-To: <1464781066-25975-1-git-send-email-yamada.masahiro@socionext.com>
References: <1464781066-25975-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160603192345.GG3761@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2016 at 08:37:46PM +0900, Masahiro Yamada wrote:
> Commit 307d40c56b0c ("ARM: uniphier: rework SMP code to support new
> System Bus binding") added a new DT binding for SMP code, but still
> kept old code for the backward compatibility.
> 
> Linux 4.6 was out with both bindings supported, so it should not
> hurt to drop the old code now.  Moreover, the mainline code are
> currently not used for any of our products, so this change has
> no impact on our customers in any way.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - Add more explanation in git-log

Thanks, applied to next/cleanup for 4.8.


-Olof

From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Sep 2012 13:18:18 +0000
Subject: [PATCH V4 6/6] arm: l2x0: add aurora related properties to OF
 binding
In-Reply-To: <1348213574-18494-7-git-send-email-gregory.clement@free-electrons.com>
References: <1348213574-18494-1-git-send-email-gregory.clement@free-electrons.com>
 <1348213574-18494-7-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <201209211318.19030.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 September 2012, Gregory CLEMENT wrote:
> Aurora is a L2 Cache Controller designed to be compatible with the
> L2x0 Cache Controller. L2X0 OF bindings are extended to support some
> specificity of Aurora (no cache id part number available through
> hardware, always write through mode, choice between outer cache and
> system cache).
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Yehuda Yitschak <yehuday@marvell.com>
> Tested-and-reviewed-by: Lior Amsalem <alior@marvell.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

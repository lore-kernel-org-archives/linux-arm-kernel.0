From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 15 Nov 2013 21:24:42 +0000 (UTC)
Subject: [PATCH] arm: pxa: tosa: fix keys mapping
References: <1382004207-6933-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <l663ep$u7c$1@ger.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Oct 2013 14:03:27 +0400, Dmitry Eremin-Solenikov wrote:

> When converting from tosa-keyboard driver to matrix keyboard, tosa keys
> received extra 1 column shift. Replace that with correct values to make
> keyboard work again.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  arch/arm/mach-pxa/tosa.c | 102
>  +++++++++++++++++++++++------------------------
>  1 file changed, 51 insertions(+), 51 deletions(-)

Ping?

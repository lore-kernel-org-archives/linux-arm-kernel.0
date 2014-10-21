From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 21 Oct 2014 20:10:00 +0400
Subject: [PATCH] ARM: davinci: Remove redundant casts
In-Reply-To: <1413903211-3143-1-git-send-email-linux@rasmusvillemoes.dk>
References: <1413903211-3143-1-git-send-email-linux@rasmusvillemoes.dk>
Message-ID: <54468558.8040204@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10/21/2014 06:53 PM, Rasmus Villemoes wrote:

> These casts to char* are unnecessary and slightly confusing, since
> both operands actually have type const char*.

    Both operands of what? Typecast only has 1 operand. :-)

> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

WBR, Sergei

From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 21 Jun 2016 21:41:34 +0800
Subject: [PATCH v4 0/5] i.MX L2-cache code cleanups and performance tweaks
In-Reply-To: <1466298571-7888-1-git-send-email-andrew.smirnov@gmail.com>
References: <1466298571-7888-1-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <20160621134134.GA26954@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 18, 2016 at 06:09:26PM -0700, Andrey Smirnov wrote:
> Andrey Smirnov (5):
>   i.MX: system.c: Convert goto to if statement
>   i.MX: system.c: Remove redundant errata 752271 code
>   i.MX: system.c: Replace magic numbers
>   i.MX: system.c: Tweak prefetch settings for performance
>   i.MX: Do not explicitly call l2x0_of_init()

Applied all, thanks.

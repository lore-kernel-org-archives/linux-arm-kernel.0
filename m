From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 27 Sep 2010 00:15:36 +0100
Subject: [PATCH v2 4/5] h1940: Fix backlight and LCD power functions
In-Reply-To: <1284241518-32587-1-git-send-email-anarsoul@gmail.com>
References: <1283871605-32068-5-git-send-email-anarsoul@gmail.com>
	<1284241518-32587-1-git-send-email-anarsoul@gmail.com>
Message-ID: <4C9FD418.8030101@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/10 22:45, Vasily Khoruzhick wrote:

Could I have a better explanation of what this part is doing
please.

for future reference, you don't need to put 'this patch' in
the description, that part is pretty clear.

> v2: init gpio mode/value right after gpio_request

It would be helpful to move the changes between submisisons
to under the --- lines to make them easier to remove when
applying to the tree.

> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  arch/arm/mach-s3c2410/include/mach/h1940-latch.h |    2 +-
>  arch/arm/mach-s3c2410/mach-h1940.c               |   80 ++++++++++++++++++----
>  2 files changed, 66 insertions(+), 16 deletions(-)

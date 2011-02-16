From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 16 Feb 2011 09:39:35 +0100
Subject: [PATCH 1/9] mfd-core: rename platform_data field of mfd_cell
	to mfd_data
In-Reply-To: <1297808729-21110-2-git-send-email-dilinger@queued.net>
References: <1297808729-21110-1-git-send-email-dilinger@queued.net>
	<1297808729-21110-2-git-send-email-dilinger@queued.net>
Message-ID: <4D5B8D47.2010809@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/15/2011 11:25 PM, Andres Salomon wrote:
> Rename the platform_data variable to imply a distinction between
> common platform_data driver usage (typically accessed via
> pdev->dev.platform_data) and the way MFD passes data down to
> clients (using a wrapper named mfd_get_data).
>
> All clients have already been changed to use the wrapper function,
> so this can be a quick single-commit change that only touches things
> in drivers/mfd.
>
> Signed-off-by: Andres Salomon<dilinger@queued.net>
>    

Thanks, I like easy-to-read code.
Acked-by: Linus Walleij <linus.walleij@stericsson.com>

Yours,
Linus Walleij

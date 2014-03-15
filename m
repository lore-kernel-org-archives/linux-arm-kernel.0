From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 15 Mar 2014 14:25:09 -0700
Subject: [PATCH v4 1/9] watchdog: orion: Move the register ioremap'ing
 to its own function
In-Reply-To: <1394907484-26002-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1394907484-26002-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1394907484-26002-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <5324C535.6010009@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/15/2014 11:17 AM, Ezequiel Garcia wrote:
> Follow-up patches will extend the registers ioremap and request
> to handle SoC-specific quirks on the RSTOUT register. Therefore,
> in order to keep the code readable, this commit introduces a special
> function for this.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

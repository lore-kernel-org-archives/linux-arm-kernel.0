From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 7 Dec 2010 15:31:37 -0800
Subject: [PATCH 1/2] dmaengine i.MX SDMA: initialize on module_init
In-Reply-To: <1291630198-9690-2-git-send-email-s.hauer@pengutronix.de>
References: <1291630198-9690-1-git-send-email-s.hauer@pengutronix.de>
	<1291630198-9690-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <AANLkTikcCShzZLykX9YrrT3kbCOknDnAS0YMenytYgdG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 6, 2010 at 2:09 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> The firmware framework gets initialized during fs_initcall time, so
> we are not allowed to call request_firmware earlier.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---

Applied.

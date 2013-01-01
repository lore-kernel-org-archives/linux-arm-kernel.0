From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Tue, 01 Jan 2013 20:41:07 +0100
Subject: [PATCH RESEND 4/6] clk: s5p-tv: Fix incorrect usage of
 IS_ERR_OR_NULL
In-Reply-To: <1355852048-23188-5-git-send-email-linux@prisktech.co.nz>
References: <1355852048-23188-1-git-send-email-linux@prisktech.co.nz>
 <1355852048-23188-5-git-send-email-linux@prisktech.co.nz>
Message-ID: <50E33BD3.9020400@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/18/2012 06:34 PM, Tony Prisk wrote:
> Resend to include mailing lists.

In the future please put such comments after the --- tear line below.

> Replace IS_ERR_OR_NULL with IS_ERR on clk_get results.
>
> Signed-off-by: Tony Prisk<linux@prisktech.co.nz>
> CC: Kyungmin Park<kyungmin.park@samsung.com>
> CC: Tomasz Stanislawski<t.stanislaws@samsung.com>
> CC: linux-media at vger.kernel.org
> ---
>   drivers/media/platform/s5p-tv/hdmi_drv.c  |   10 +++++-----
>   drivers/media/platform/s5p-tv/mixer_drv.c |   10 +++++-----
>   drivers/media/platform/s5p-tv/sdo_drv.c   |   10 +++++-----
>   3 files changed, 15 insertions(+), 15 deletions(-)

Applied, after resolving conflict with other patch that addressed
those issues in sdo_drv.c file. Thanks.

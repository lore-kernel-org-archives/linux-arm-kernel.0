From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 30 Apr 2018 11:28:17 +0200
Subject: [PATCH 43/61] pwm: simplify getting .drvdata
In-Reply-To: <20180419140641.27926-44-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-44-wsa+renesas@sang-engineering.com>
Message-ID: <20180430092817.GB2270@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2018 at 04:06:13PM +0200, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/pwm/pwm-atmel-tcb.c | 6 ++----
>  drivers/pwm/pwm-rcar.c      | 3 +--
>  2 files changed, 3 insertions(+), 6 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180430/a8897b98/attachment.sig>

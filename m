From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 25 Jun 2014 14:17:56 +0800
Subject: [PATCH v2 1/2] video: imxfb: Fix unbalanced regulators
In-Reply-To: <1403528839-31901-1-git-send-email-denis@eukrea.com>
References: <1403528839-31901-1-git-send-email-denis@eukrea.com>
Message-ID: <20140625061754.GB3242@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 23, 2014 at 03:07:18PM +0200, Denis Carikli wrote:
> Both regulator_enable and regulator_disable's comments
> say that they must be balanced with its counterpart
> enable/disable function.
> 
> Not doing it result in kernel warnings each time
> the lcd is powered off twice, for instance trough sysfs.
> 
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> Changelog v1->v2:
>  - None
> ---
>  drivers/video/fbdev/imxfb.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This two patches should have fbdev maintainers and list on copy.

Shawn

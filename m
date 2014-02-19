From: mporter@linaro.org (Matt Porter)
Date: Wed, 19 Feb 2014 16:31:27 -0500
Subject: [PATCH] ARM: dts: remove bcm11351-brt.dts
In-Reply-To: <53052059.3020105@linaro.org>
References: <1392840808-28214-1-git-send-email-mporter@linaro.org>
 <53052059.3020105@linaro.org>
Message-ID: <20140219213127.GL29906@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 03:21:29PM -0600, Alex Elder wrote:
> On 02/19/2014 02:13 PM, Matt Porter wrote:
> > The BCM11351 BRT board will never see the light of day. Remove the BRT
> > dts since it is not maintainable.
> > 
> > Signed-off-by: Matt Porter <mporter@linaro.org>
> 
> Please remove the line in the Makefile that refers to this file.
> Provided you make that change, it looks good to me.
> 
> Reviewed-by: Alex Elder <elder@linaro.org>

Done, thanks.

-Matt

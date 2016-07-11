From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 11 Jul 2016 11:55:52 +0200
Subject: [PATCH v8 3/9] pwm: pwm-tiehrpwm: Update dt binding document to
 use generic node name
In-Reply-To: <1462291015-1919-4-git-send-email-fcooper@ti.com>
References: <1462291015-1919-1-git-send-email-fcooper@ti.com>
 <1462291015-1919-4-git-send-email-fcooper@ti.com>
Message-ID: <20160711095552.GH5823@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 03, 2016 at 10:56:49AM -0500, Franklin S Cooper Jr wrote:
> Now that the node name has been changed from ehrpwm to pwm the document
> should show this proper usage. Change the unit address in the example
> from 0 to the proper physical address value that should be used. Also
> insure that the unit address matches to the reg property.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

I applied this long ago, but never replied: Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160711/cd4bbaf3/attachment.sig>

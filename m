From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 11 Jul 2016 11:56:23 +0200
Subject: [PATCH v8 4/9] pwm: pwm-tiecap: Update dt binding document to
 use proper unit address
In-Reply-To: <1462291015-1919-5-git-send-email-fcooper@ti.com>
References: <1462291015-1919-1-git-send-email-fcooper@ti.com>
 <1462291015-1919-5-git-send-email-fcooper@ti.com>
Message-ID: <20160711095623.GI5823@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 03, 2016 at 10:56:50AM -0500, Franklin S Cooper Jr wrote:
> Replace unit address from 0 to the proper physical address. Also insure
> that the unit address matches the reg property address.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

I applied this long ago but never let you know: Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160711/ec249f32/attachment-0001.sig>

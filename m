From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 21 Aug 2017 07:28:21 +0200
Subject: [PATCH V2 0/2] pwm: bcm2835: Support for polarity setting via DT
In-Reply-To: <1502533184-15765-1-git-send-email-stefan.wahren@i2se.com>
References: <1502533184-15765-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20170821052821.GA18996@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 12, 2017 at 12:19:42PM +0200, Stefan Wahren wrote:
> This patch series adds support for the third (optional) pwm cell to specify the
> polarity.
> 
> Changes in V2:
> * add ack and review tags
> 
> Stefan Wahren (2):
>   dt-bindings: pwm-bcm2835: Increase pwm-cells
>   pwm: bcm2835: Support for polarity setting via DT
> 
>  Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt | 4 ++--
>  drivers/pwm/pwm-bcm2835.c                             | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)

Both patches applied to for-4.14/drivers, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170821/d3f57336/attachment.sig>

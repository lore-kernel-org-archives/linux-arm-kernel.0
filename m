From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 20 Jul 2015 09:52:09 +0200
Subject: [RFC PATCH 03/15] pwm: add pwm_get_polarity helper function
In-Reply-To: <1435738921-25027-4-git-send-email-boris.brezillon@free-electrons.com>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-4-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150720075209.GD29614@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 01, 2015 at 10:21:49AM +0200, Boris Brezillon wrote:
> Some drivers are directly accessing the ->polarity field in pwm_device.
> Add an helper to retrieve the current polarity so that we can easily move
> this field elsewhere (required to support atomic update).
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  include/linux/pwm.h | 5 +++++
>  1 file changed, 5 insertions(+)

Applied thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150720/934ee3a4/attachment-0001.sig>

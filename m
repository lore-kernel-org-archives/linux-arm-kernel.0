From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 5 Sep 2016 12:35:54 +0200
Subject: [PATCH v4 08/17] pwm: sti: Reorganise register names in
 preparation for new functionality
In-Reply-To: <20160816093508.28307-9-lee.jones@linaro.org>
References: <20160816093508.28307-1-lee.jones@linaro.org>
 <20160816093508.28307-9-lee.jones@linaro.org>
Message-ID: <20160905103554.GH31424@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 10:34:59AM +0100, Lee Jones wrote:
> Exciting functionality is on the way to this device.  But
> before we can add it, we need to do some basic housekeeping
> so the additions can be added cleanly.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/pwm-sti.c | 76 +++++++++++++++++++++++++++------------------------
>  1 file changed, 41 insertions(+), 35 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160905/6abfe106/attachment.sig>

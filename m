From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 6 Nov 2015 15:51:38 +0100
Subject: [PATCH 05/10] pwm: sysfs: do not unnecessarily store result in var
In-Reply-To: <1445895161-2317-6-git-send-email-o.schinagl@ultimaker.com>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
 <1445895161-2317-6-git-send-email-o.schinagl@ultimaker.com>
Message-ID: <20151106145138.GB8418@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 10:32:36PM +0100, Olliver Schinagl wrote:
> From: Olliver Schinagl <oliver@schinagl.nl>
> 
> Use the result of pwm_is_enabled directly instead of storing it first.
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> ---
>  drivers/pwm/sysfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151106/8b1b38aa/attachment.sig>

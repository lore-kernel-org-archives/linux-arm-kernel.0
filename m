From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 6 Nov 2015 15:52:58 +0100
Subject: [PATCH 06/10] pwm: sysfs: make use of the DEVICE_ATTR_[RW][WO]
 macro's
In-Reply-To: <1445895161-2317-7-git-send-email-o.schinagl@ultimaker.com>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
 <1445895161-2317-7-git-send-email-o.schinagl@ultimaker.com>
Message-ID: <20151106145258.GC8418@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 10:32:37PM +0100, Olliver Schinagl wrote:
> From: Olliver Schinagl <oliver@schinagl.nl>
> 
> For the npwm property the pwm sysfs interface already made use of the
> DEVICE_ATTR_RO macro. This patch expands this to the other sysfs
> properties so that the code base is concise and makes use of this
> helpful macro.
> 
> This has the advantage of slightly reducing the code size, improving
> readability and no longer using magic values for permissions.
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> ---
>  drivers/pwm/sysfs.c | 72 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 36 insertions(+), 36 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151106/671d537d/attachment.sig>

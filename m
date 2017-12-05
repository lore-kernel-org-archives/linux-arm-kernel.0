From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 5 Dec 2017 09:27:42 +0100
Subject: [RESEND][PATCH] pwm: Set class for exported channels in sysfs
In-Reply-To: <1496397921-1713-1-git-send-email-gottfried.haider@gmail.com>
References: <1496397921-1713-1-git-send-email-gottfried.haider@gmail.com>
Message-ID: <20171205082742.GA7174@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 02, 2017 at 10:05:21AM +0000, Gottfried Haider wrote:
> Notifications for devices without bus or class set get dropped by
> dev_uevent_filter. Adding the class to the exported child matches
> what the gpio subsystem is doing.
> 
> With this change exporting a channel triggers a udev event, which
> gives userspace a chance to fixup permissions and makes it possible
> for non-root users to make use of the pwm subsystem.
> 
> Signed-off-by: Gottfried Haider <gottfried.haider@gmail.com>
> CC: Thierry Reding <thierry.reding@gmail.com>
> CC: H Hartley Sweeten <hsweeten@visionengravers.com>
> CC: linux-pwm at vger.kernel.org
> CC: linux-arm-kernel at lists.infradead.org
> CC: linux-rpi-kernel at lists.infradead.org
> ---
>  drivers/pwm/sysfs.c | 1 +
>  1 file changed, 1 insertion(+)

Sorry for the long delay, applied to for-next now.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171205/5ba41b60/attachment-0001.sig>

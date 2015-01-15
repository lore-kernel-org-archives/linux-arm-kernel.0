From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 15 Jan 2015 14:44:33 +0100
Subject: [PATCH RESEND V2 2/2] power: collie_battery: support generating
 wakeup event
In-Reply-To: <1421287238-23522-2-git-send-email-dbaryshkov@gmail.com>
References: <1421287238-23522-1-git-send-email-dbaryshkov@gmail.com>
 <1421287238-23522-2-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20150115134432.GB512@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 15, 2015 at 05:00:38AM +0300, Dmitry Eremin-Solenikov wrote:
> Teach collie_battery driver to communicate to the kernel that it can
> generate wakeup events. Handle enabling/disabling wakeup on battery full
> event in suspend/resume callbacks.

Thanks, applied:

http://git.infradead.org/battery-2.6.git/commit/a465005643a4c1e02681b02075082fc6c7fa076a

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150115/773763bd/attachment.sig>

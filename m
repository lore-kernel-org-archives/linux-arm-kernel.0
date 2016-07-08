From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 8 Jul 2016 17:16:12 +0200
Subject: [PATCH v5 2/3] pwm: iproc: Add support for Broadcom iproc pwm
 controller
In-Reply-To: <1467698426-27600-3-git-send-email-yendapally.reddy@broadcom.com>
References: <1467698426-27600-1-git-send-email-yendapally.reddy@broadcom.com>
 <1467698426-27600-3-git-send-email-yendapally.reddy@broadcom.com>
Message-ID: <20160708151612.GB1151@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2016 at 02:00:25AM -0400, Yendapally Reddy Dhananjaya Reddy wrote:
> Add support for the PWM controller present in Broadcom's iProc
> family of SoCs.It has been tested on the  Northstar+ bcm958625HR board.
> 
> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
> ---
>  drivers/pwm/Kconfig         |  10 ++
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-bcm-iproc.c | 268 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 279 insertions(+)
>  create mode 100644 drivers/pwm/pwm-bcm-iproc.c

I've applied this, but I had to make a couple of changes for coding
style and to squash compiler warnings. Please check the PWM tree's
for-next branch to see if it still works for you.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160708/f7673726/attachment.sig>

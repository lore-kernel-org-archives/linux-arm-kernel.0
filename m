From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 12 Jun 2015 12:25:30 +0200
Subject: [PATCH v2 2/2] pwm: add MediaTek display PWM driver support
In-Reply-To: <1432214964-40644-3-git-send-email-yh.huang@mediatek.com>
References: <1432214964-40644-1-git-send-email-yh.huang@mediatek.com>
 <1432214964-40644-3-git-send-email-yh.huang@mediatek.com>
Message-ID: <20150612102529.GH19400@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 09:29:24PM +0800, YH Huang wrote:
> Add display PWM driver support to modify backlight for MT8173.

The driver also claims compatibility with MT6595, so you should mention
that here as well. Also please be more verbose in the commit message.
You should mention things like how many channels the PWM has or typical
use-cases.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150612/dd83fd85/attachment.sig>

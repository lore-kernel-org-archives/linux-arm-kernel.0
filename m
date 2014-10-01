From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 1 Oct 2014 17:18:47 +0200
Subject: [PATCH RESEND V9 1/6] power: reset: Add generic SYSCON register
 mapped reset
In-Reply-To: <1412119508-22864-2-git-send-email-fkan@apm.com>
References: <1412119508-22864-1-git-send-email-fkan@apm.com>
 <1412119508-22864-2-git-send-email-fkan@apm.com>
Message-ID: <20141001151847.GC969@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 30, 2014 at 04:25:03PM -0700, Feng Kan wrote:
> Add a generic SYSCON register mapped reset mechanism.
> 
> Signed-off-by: Feng Kan <fkan@apm.com>

I have merged the driver and its documentation to battery-2.6.git.
This should make it possible for the changes in arch/arm to be
merged via ARM maintainers in 3.19.

Please fix Guenter's comments in an incremental patch.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141001/8c6df568/attachment-0001.sig>

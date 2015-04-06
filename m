From: sre@kernel.org (Sebastian Reichel)
Date: Mon, 6 Apr 2015 19:45:15 +0200
Subject: [PATCH v4 6/6] power: twl4030_madc_battery: Add missing
 MODULE_ALIAS
In-Reply-To: <1426022847-30912-7-git-send-email-marek@goldelico.com>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com>
 <1426022847-30912-7-git-send-email-marek@goldelico.com>
Message-ID: <20150406174515.GF18145@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 10, 2015 at 10:27:27PM +0100, Marek Belisko wrote:
> Without MODULE_ALIAS twl4030_madc_battery won't get loaded
> automatically.

Thanks, pulled.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150406/2c379b67/attachment.sig>

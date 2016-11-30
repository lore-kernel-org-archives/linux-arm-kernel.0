From: balbi@kernel.org (Felipe Balbi)
Date: Wed, 30 Nov 2016 12:42:41 +0200
Subject: [PATCH 11/12] usb: phy: tahvo: Replace the deprecated extcon API
In-Reply-To: <1480485460-2663-12-git-send-email-cw00.choi@samsung.com>
References: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
 <1480485460-2663-12-git-send-email-cw00.choi@samsung.com>
Message-ID: <87shq9meou.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Chanwoo Choi <cw00.choi@samsung.com> writes:
> This patch replaces the deprecated extcon API as following:
> - extcon_set_cable_state_() -> extcon_set_state_sync()
>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161130/1ab45db2/attachment.sig>

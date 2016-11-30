From: balbi@kernel.org (Felipe Balbi)
Date: Wed, 30 Nov 2016 12:43:39 +0200
Subject: [PATCH 12/12] usb: renesas_usbhs: Replace the deprecated extcon
 API
In-Reply-To: <1480485460-2663-13-git-send-email-cw00.choi@samsung.com>
References: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
 <1480485460-2663-13-git-send-email-cw00.choi@samsung.com>
Message-ID: <87poldmen8.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Chanwoo Choi <cw00.choi@samsung.com> writes:
> This patch replaces the deprecated extcon API as following:
> - extcon_get_cable_state_() -> extcon_get_state()
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161130/85910a19/attachment.sig>

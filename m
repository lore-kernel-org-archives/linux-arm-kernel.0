From: balbi@kernel.org (Felipe Balbi)
Date: Tue, 15 Aug 2017 12:48:41 +0300
Subject: [PATCH v2 4/5] usb: gadget: udc: Replace the deprecated extcon API
In-Reply-To: <1501748448-26821-5-git-send-email-cw00.choi@samsung.com>
References: <1501748448-26821-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170803082050epcas1p2491eedf2f26510f55cd15ce777356fce@epcas1p2.samsung.com>
 <1501748448-26821-5-git-send-email-cw00.choi@samsung.com>
Message-ID: <87mv716u12.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Chanwoo Choi <cw00.choi@samsung.com> writes:
> This patch replaces the deprecated extcon API as following:
> - extcon_get_cable_state_() -> extcon_get_state()
>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Raviteja Garimella <raviteja.garimella@broadcom.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

Do you want to take these through your tree or mine? In case you want
them in your tree:

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170815/b4a37b53/attachment.sig>

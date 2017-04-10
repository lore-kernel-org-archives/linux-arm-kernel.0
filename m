From: felipe.balbi@linux.intel.com (Felipe Balbi)
Date: Mon, 10 Apr 2017 13:21:22 +0300
Subject: [PATCH 12/14] usb: dwc2: simplify optional reset handling
In-Reply-To: <20170130114116.22089-12-p.zabel@pengutronix.de>
References: <20170130114116.22089-1-p.zabel@pengutronix.de>
 <20170130114116.22089-12-p.zabel@pengutronix.de>
Message-ID: <87o9w4ef6l.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Philipp Zabel <p.zabel@pengutronix.de> writes:
> As of commit bb475230b8e5 ("reset: make optional functions really
> optional"), the reset framework API calls use NULL pointers to describe
> optional, non-present reset controls.
>
> This allows to return errors from devm_reset_control_get_optional and to
> call reset_control_(de)assert unconditionally.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
> Cc: John Youn <johnyoun@synopsys.com>
> Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

doesn't apply to testing/next. Care to rebase and resend? Also, please
Cc linux-usb ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170410/3b9a66ef/attachment.sig>

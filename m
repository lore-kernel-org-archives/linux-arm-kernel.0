From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 10 Apr 2017 12:36:56 +0200
Subject: [PATCH 12/14] usb: dwc2: simplify optional reset handling
In-Reply-To: <87o9w4ef6l.fsf@linux.intel.com>
References: <20170130114116.22089-1-p.zabel@pengutronix.de>
 <20170130114116.22089-12-p.zabel@pengutronix.de>
 <87o9w4ef6l.fsf@linux.intel.com>
Message-ID: <1491820616.3087.34.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On Mon, 2017-04-10 at 13:21 +0300, Felipe Balbi wrote:
> Hi,
> 
> Philipp Zabel <p.zabel@pengutronix.de> writes:
> > As of commit bb475230b8e5 ("reset: make optional functions really
> > optional"), the reset framework API calls use NULL pointers to describe
> > optional, non-present reset controls.
> >
> > This allows to return errors from devm_reset_control_get_optional and to
> > call reset_control_(de)assert unconditionally.
> >
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
> > Cc: John Youn <johnyoun@synopsys.com>
> > Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> doesn't apply to testing/next. Care to rebase and resend?

v2 is already applied as commit 5a6e4f46abd5 ("usb: dwc2: simplify
optional reset handling"), as far as I can tell.

> Also, please Cc linux-usb ;-)

I messed up the Cc: list on the first submission, but v2 should have
made it to linux-usb.

regards
Philipp

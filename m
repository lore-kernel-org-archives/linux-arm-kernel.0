From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 26 Mar 2013 16:34:33 -0700
Subject: [PATCH] serial: 8250_dw: add support for clk api
In-Reply-To: <515179E6.4020709@free-electrons.com>
References: <1363689316-7847-2-git-send-email-maxime.ripard@free-electrons.com>
 <1363690369-8067-1-git-send-email-maxime.ripard@free-electrons.com>
 <20130321084707.GB2862@xps8300>
 <515179E6.4020709@free-electrons.com>
Message-ID: <20130326233433.GA31077@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 26, 2013 at 11:35:18AM +0100, Maxime Ripard wrote:
> Hi Greg,
> 
> Le 21/03/2013 09:47, Heikki Krogerus a ?crit :
> > On Tue, Mar 19, 2013 at 11:52:49AM +0100, Maxime Ripard wrote:
> >> From: Emilio L?pez <emilio@elopez.com.ar>
> >>
> >> This commit implements support for using the clk api; this lets us use
> >> the "clocks" property with device tree, instead of having to use
> >> clock-frequency.
> >>
> >> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> > 
> > FWIW,
> > 
> > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> Would you consider merging this patch, or do you have additional comments?
> 
> We have several patch series that depends on this one that I'd like to
> see included in 3.10, and we begin to see the end of the 3.9 release cycle.

You resent one patch, in the middle of a 7 patch series, with me on the
 cc: and somehow expected me to know that I was supposed to apply it?

Please be specific and realistic with your requests.

Resend it if you feel I should apply it.

greg k-h

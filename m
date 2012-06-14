From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 14 Jun 2012 08:46:24 -0700
Subject: [PATCH v4] usb: chipidea: permit driver bindings pass phy pointer
In-Reply-To: <8762au8h46.fsf@ashishki-desk.ger.corp.intel.com>
References: <1337912665-16615-3-git-send-email-richard.zhao@freescale.com>
 <1339159026-15837-1-git-send-email-richard.zhao@freescale.com>
 <20120612231438.GA6177@kroah.com>
 <8762au8h46.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20120614154624.GF17140@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 10:52:57AM +0300, Alexander Shishkin wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> 
> > On Fri, Jun 08, 2012 at 08:37:06PM +0800, Richard Zhao wrote:
> >> Sometimes, the driver bindings may know what phy they use.
> >> For example, when using device tree, the usb controller may have a
> >> phandler pointing to usb phy.
> >> 
> >> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> >> Reviewed-by: Marek Vasut <marex@denx.de>
> >> Acked-by: Felipe Balbi <balbi@ti.com>
> >> ---
> >> Changes since laster version:
> >> - hcd transceiver renamed to phy
> >
> > Ick, I see patches all over this thread, and other threads, and I have
> > no idea what to apply anywhere...
> >
> > So, consider all chipidea patches dropped from my queue now, can you
> > please resend them to me, with the accumulated acks and reviewed-by
> > line, so that I can queue them up?
> 
> So will you pick these patches to your tree or should I apply them to
> mine or what is the plan? I kind of have a tree [1] for chipidea stuff
> where I have been collecting patches, to send a pull request to you for
> 3.6.

I do not accept pull requests for this code, sorry, I need patches in
email.  You and Richard work it out how you are going to handle this and
then, send me patches that you both agree on.

thanks,

greg k-h

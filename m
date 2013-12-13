From: balbi@ti.com (Felipe Balbi)
Date: Thu, 12 Dec 2013 18:43:37 -0600
Subject: [PATCH v2 1/7] usb: dwc3: keystone: add basic PM support
In-Reply-To: <52AA54E4.5000606@ti.com>
References: <20131212214306.GS1939@saruman.home>
 <1386884755-12366-1-git-send-email-balbi@ti.com>
 <52AA54E4.5000606@ti.com>
Message-ID: <20131213004337.GA31622@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 07:29:24PM -0500, Santosh Shilimkar wrote:
> On Thursday 12 December 2013 04:45 PM, Felipe Balbi wrote:
> > A bare-minimum PM implementation which will
> > server as building block for more complex
> s/server/serve ;-)

hah! :-) will fix in my branch.

> > PM implementation in the future.
> > 
> > At the least will not leave clocks on unnecessarily
> > when e.g.  a user write mem to /sys/power/state.
> > 
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> > 
> > improve error path a little bit.
> > 
> We will test this out. Thanks for the
> patch Felipe.

thanks.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/db14b78b/attachment.sig>

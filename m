From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 19 Jun 2012 15:33:52 +0200
Subject: [PATCHv8 13/13] I2C: OMAP: simplify omap_i2c_ack_stat()
In-Reply-To: <CAM=Q2ctOS19ToH7JRLxmEkoz8eUj8umcWFhaTQ-MWBbeh_DHtA@mail.gmail.com>
References: <1340029828-20751-1-git-send-email-shubhrajyoti@ti.com>
 <1340029828-20751-14-git-send-email-shubhrajyoti@ti.com>
 <20120618153000.GC10768@pengutronix.de>
 <CAM=Q2ctOS19ToH7JRLxmEkoz8eUj8umcWFhaTQ-MWBbeh_DHtA@mail.gmail.com>
Message-ID: <20120619133352.GB18711@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2012 at 02:50:23PM +0530, Shubhrajyoti Datta wrote:
> On Mon, Jun 18, 2012 at 9:00 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> > On Mon, Jun 18, 2012 at 08:00:28PM +0530, Shubhrajyoti D wrote:
> >> From: Felipe Balbi <balbi@ti.com>
> >>
> >> stat & BIT(1) is the same as BIT(1),
> >
> > Not true. I'd guess you are missing some context in the patch
> > description.
> 
> 
> See the explanation , hope I understood your concern correctly.
> 
> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg70277.html

The code may be right, but as Russell pointed out, the patch description
is very weak. I could read the mail now to understand, but I prefer to
wait for a better patch description. Because I need to ensure other
people reading the git history later will understand easily without
having to search the web.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120619/f49d51fb/attachment.sig>

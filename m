From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 24 Mar 2016 17:52:55 +0100
Subject: [PATCH v5 0/2] power: reset: support for Atmel alternative
 Shutdown Controller
In-Reply-To: <56F3AB12.20701@atmel.com>
References: <1458134390-23847-1-git-send-email-nicolas.ferre@atmel.com>
 <56F27B96.5010406@atmel.com> <20160323211144.GA31473@earth>
 <56F3AB12.20701@atmel.com>
Message-ID: <20160324165254.GA31831@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 24, 2016 at 09:53:38AM +0100, Nicolas Ferre wrote:
> Le 23/03/2016 22:11, Sebastian Reichel a ?crit :
> > Hi Nicolas,
> > 
> > On Wed, Mar 23, 2016 at 12:18:46PM +0100, Nicolas Ferre wrote:
> >> Le 16/03/2016 14:19, Nicolas Ferre a ?crit :
> >>> This is a series to add driver for a new Atmel Shutdown Controller. This new IP
> >>> is extensible and some features will be added later (see the TODO section).
> >>> Its extensible nature led to write a new binding so that wake-up sources can be
> >>> described easily.
> >>
> >> I have the feeling that this series is ready. What do you think?
> > 
> > I have see obvious problems with this series and plan to queue this
> 
> I would be reassured if a "not" was actually missing in the sentence
> above... ;-)

Sorry, it's missing of course (I do not intent to queue stuff with
obvious problems ;)).

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160324/570a8ff3/attachment.sig>

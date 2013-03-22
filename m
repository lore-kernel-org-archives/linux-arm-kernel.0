From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 22 Mar 2013 10:24:08 -0400 (EDT)
Subject: [PATCH] USB: EHCI: fix for leaking isochronous data
In-Reply-To: <514B86A9.60401@web.de>
Message-ID: <Pine.LNX.4.44L0.1303221023310.1294-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Mar 2013, Soeren Moch wrote:

> > Hi Alan, Soeren
> >
> > Could you word the description a bit better. If Alan did not get it
> > without a bit of thought, few others are going to understand it
> > without a better explanation.
> >
> > Thanks
> > 	Andrew
> >
> 
> Alan,
> 
> can you come up with a better explanation, please? I think your 
> description how it is supposed to work from here
>     http://marc.info/?l=linux-usb&m=136345559432055&w=2
> is required to understand the problem and the fix.

Okay, I will rewrite your patch description.

Alan Stern

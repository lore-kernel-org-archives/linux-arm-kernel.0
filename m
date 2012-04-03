From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 3 Apr 2012 11:25:53 -0400 (EDT)
Subject: [PATCH v2 06/13] USB: ohci-at91: change maximum number of ports
In-Reply-To: <4F7B1174.5070300@atmel.com>
Message-ID: <Pine.LNX.4.44L0.1204031125060.1537-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 3 Apr 2012, Nicolas Ferre wrote:

> > Did you run this patch through scripts/checkpatch.pl?  I have the 
> > feeling that it might complain about some of the changes.
> 
> Yes, definitively.
> 
> I can modify the patch to comply with error issued by checkpatch.pl: several are
> due to a bad replacement of previous code with my regular expression but others
> where existing before my modifications.
> So what do you think about:
>  - addressing all style errors in this patch (to prevent carrying them)
>  - merging this one and the following patch:
>    "[PATCH v2 07/13] USB: ohci-at91: coding style modifications with one-line ifs
>  - posting a v3 of this patch only if you agree on this...

Sure, go ahead.  Aside from this minor issue I didn't notice anything 
objectionable in the patch series.

Alan Stern

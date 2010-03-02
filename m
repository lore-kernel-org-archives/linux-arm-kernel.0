From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 2 Mar 2010 12:43:33 -0500 (EST)
Subject: [RFC PATCH v2 8/9] USB: add HCD_NO_COHERENT_MEM host controller
	driver flag
In-Reply-To: <4B8D44A7.7030302@yahoo.es>
Message-ID: <Pine.LNX.4.44L0.1003021236560.1375-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2 Mar 2010, Albert Herranz wrote:

> > Currently "this URB doesn't require PIO" is always true, but in the 
> > future it won't be.
> > 
> 
> Can this be currently tested?

Not yet, but soon.  You can follow the gory details in this email 
thread:

	http://marc.info/?l=linux-usb&m=126477569707174&w=2

See especially this email:

	http://marc.info/?l=linux-usb&m=126630714002200&w=2

> Should I make provisions for this check now too?

Don't worry about it.  If you structure the code as I described, it 
will be easy to insert the check later on.

Alan Stern

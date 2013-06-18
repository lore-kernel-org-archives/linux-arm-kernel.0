From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 18 Jun 2013 12:55:13 -0400 (EDT)
Subject: [RFC PATCH v1 6/6] USB: EHCI: support running URB giveback in
 tasklet context
In-Reply-To: <1371567833-9077-7-git-send-email-ming.lei@canonical.com>
Message-ID: <Pine.LNX.4.44L0.1306181252320.1157-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Jun 2013, Ming Lei wrote:

> Both 4 transfers can work well on EHCI HCD after switching to run

"Both 4 transfers"?  The word "both" applies when there are two items, 
not more than two.  And what are the four transfers you are referring 
to?  Do you mean all four transfer _types_?

Alan Stern

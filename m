From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 20 Feb 2013 11:37:31 -0500 (EST)
Subject: [V2 5/8] USB: EHCI: make ehci-vt8500 a separate driver
In-Reply-To: <1360923853-7875-6-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1302201125410.1671-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Feb 2013, Manjunath Goudar wrote:

> Separate the vt8500 host controller driver from ehci-hcd host code
> into its own driver module.
> 
> In V2:
> Change the GPL to GPL v2 MODULE_LICENSE 

Same comments as for the other patches.

You know, when you submit a series of patches all doing basically the
same sort of thing, and somebody makes a suggestion to improve one of
them, you should always consider whether that suggestion could also
apply to the other patches in the series.  It's silly for us to send
you 8 separate emails, each telling you to make the same change to one 
particular patch in the series.

Therefore you should consider each of the problems I have described in 
the last several emails, and think about which of your patches they 
apply to.  Some of them do apply to more than one patch, even though I 
didn't say so explicitly at the time.

Alan Stern

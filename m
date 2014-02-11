From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 11 Feb 2014 12:07:48 -0500 (EST)
Subject: [PATCH 1/2] uhci-platform: Change compatible string from
 platform-uhci to generic-uhci
In-Reply-To: <1392137686-6562-1-git-send-email-hdegoede@redhat.com>
Message-ID: <Pine.LNX.4.44L0.1402111207260.1209-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Feb 2014, Hans de Goede wrote:

> This brings the uhci-platform bindings in sync with what we've done for
> the ohci- and ehci-platform drivers. As discussed there using platform as a
> prefix is a bit weird as the platform bus is a Linux specific thing and
> the bindings are supposed to be OS agnostic.
> 
> Note that the old platform-uhci compatible string is kept around for, well,
> compatibility reasons.
> 
> While at it rename the bindings txt file to match the name of all the
> other ?hci-platform bindings docs.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Alan Stern <stern@rowland.harvard.edu>

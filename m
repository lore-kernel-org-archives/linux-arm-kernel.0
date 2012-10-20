From: stern@rowland.harvard.edu (Alan Stern)
Date: Sat, 20 Oct 2012 10:34:47 -0400 (EDT)
Subject: [RFC PATCH 0/2] Update ehci-platform driver to support devicetree
In-Reply-To: <1350703053-4661-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <Pine.LNX.4.44L0.1210201032160.24222-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 20 Oct 2012, Tony Prisk wrote:

> This patchset updates the ehci-platform.c driver to allow device tree probing.
> I have dropped support for the three function pointers (power_on, power_off
> and power_suspend). If someone has knowledge of the power sequence functions
> that are being implemented, these functions could be replaced (Sorry, I don't
> know anything about implementing it).
> 
> port_power_(on_off) properties are not supported in DT as Alan Stern indicated
> they are going to be removed.
> 
> I have included a binding document, but must admit most of the descriptions
> for the properties are guessed. Quite likely some of these descriptions are
> incorrect and/or need to be clarified.

They look okay to me.  Over time we may need to add a few more entries, 
as more drivers are converted over to ehci-platform.

> Tony Prisk (2):
>   USB: Update EHCI-platform driver to devicetree.
>   USB: doc: Binding document for ehci-platform driver

This is very good; thanks for doing the work.

Alan Stern

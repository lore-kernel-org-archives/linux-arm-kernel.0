From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 20 Jun 2013 15:50:21 -0400 (EDT)
Subject: [PATCH V4 00/11] USB: OHCI:Properly handle ohci_suspend()routine
 in bus glue
In-Reply-To: <1371720968-7533-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1306201549470.879-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Jun 2013, Manjunath Goudar wrote:

> Suspend scenario in case of ohci bus glue was not properly handled as
> it was not suspending generic part of ohci controller. Calling
> explicitly the ohci_suspend()routine will ensure proper handling
> of suspend scenario.
> 
> V2:
>  -Incase ohci_suspend() fails, return right away without executing further.
> 
> V3:
>  -New patch 1/11 added, for generic ohci-hcd suspend code.
>  
> V4:
>  -Properly aligned "do_wakeup" and "ret" variables.

This whole series looks good now.  For all of the patches:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

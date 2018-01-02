From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 2 Jan 2018 14:44:14 +0100
Subject: [PATCH V4 25/26] i7300_idle: remove unused file
In-Reply-To: <121cd93d-562c-8ebd-21df-1dafbc525c80@codeaurora.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
 <1513661883-28662-26-git-send-email-okaya@codeaurora.org>
 <121cd93d-562c-8ebd-21df-1dafbc525c80@codeaurora.org>
Message-ID: <20180102134414.GA9603@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 02, 2018 at 08:36:46AM -0500, Sinan Kaya wrote:
> Hi Greg,
> 
> On 12/19/2017 12:38 AM, Sinan Kaya wrote:
> > i7300_idle.h is not being called by any source file and contains calls to
> > pci_get_bus_and_slot() that we are trying to deprecate. Remove unused file.
> > 
> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> 
> Do you think you can pick this up?

Sure, will do so, thanks.

greg k-h

From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 22 Nov 2017 17:58:29 +0100
Subject: [PATCH 29/30] i7300_idle: deprecate pci_get_bus_and_slot()
In-Reply-To: <3cca8693-72bf-db72-f698-f111c9ef707c@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
 <1511328675-21981-30-git-send-email-okaya@codeaurora.org>
 <20171122075345.GC26583@kroah.com>
 <81de37c1-26b5-41f7-ab32-b98012890971@codeaurora.org>
 <20171122164546.GB30812@kroah.com>
 <3cca8693-72bf-db72-f698-f111c9ef707c@codeaurora.org>
Message-ID: <20171122165829.GA2651@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 22, 2017 at 11:50:53AM -0500, Sinan Kaya wrote:
> On 11/22/2017 11:45 AM, Greg Kroah-Hartman wrote:
> >> Funny thing is nobody is calling this function. Maybe, I should just kill it
> >> instead.
> > Yes, delete it.  Why doesn't the build warn about it not being used?
> > 
> 
> OK. Because it is in a header file that nobody includes.

Even better, just delete the whole file!  :)

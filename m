From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 3 Apr 2012 19:40:26 +0000
Subject: [PATCH] ARM: versatile: fix build failure in pci.c
In-Reply-To: <4F7B4AF0.7080208@windriver.com>
References: <1333410505-17257-1-git-send-email-paul.gortmaker@windriver.com>
 <CAErSpo5RiDgfXHB30rOTco6CjhH4Nzovhvddifk9i=tb4QKtNQ@mail.gmail.com>
 <4F7B4AF0.7080208@windriver.com>
Message-ID: <201204031940.26977.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 April 2012, Paul Gortmaker wrote:
> On 12-04-03 12:44 PM, Bjorn Helgaas wrote:
> 
> [...]
> 
> > 
> > Since this only affects arm, do you want to handle the fix entirely in
> > the arm tree?  If you want me to push something through PCI, I can do
> > that, too.  Sorry for the breakage.
> 
> Olof already applied my patch to fixes, so I don't
> think there is any requirement for immediate action.

Yes, and this is the important part for now, making this look nice can
wait. My preference would be to get rid of the io_offset and mem_offset
in as many places as possible in the long run, but we don't have to do
that for v3.4.

> You and Arnd can work out whether you want to use
> offsets or not on the versatile at your leisure.

I have a patch set for versatile PCI that I should have sent a long
time ago. When I resubmit that, I'll take care of this, too.

	Arnd

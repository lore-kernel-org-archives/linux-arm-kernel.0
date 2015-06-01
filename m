From: will.deacon@arm.com (Will Deacon)
Date: Mon, 1 Jun 2015 11:24:48 +0100
Subject: arm syscall fast path can miss a ptrace syscall-exit
In-Reply-To: <5568C85E.8050509@redhat.com>
References: <5554F3E4.8020307@redhat.com>
 <20150514193553.GD2067@n2100.arm.linux.org.uk>
 <55550EBA.3050708@redhat.com> <5564F5E0.7080108@redhat.com>
 <20150528103710.GZ2067@n2100.arm.linux.org.uk>
 <5568C85E.8050509@redhat.com>
Message-ID: <20150601102448.GG1641@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 29, 2015 at 09:13:18PM +0100, Josh Stone wrote:
> On 05/28/2015 03:37 AM, Russell King - ARM Linux wrote:
> > On Tue, May 26, 2015 at 03:38:24PM -0700, Josh Stone wrote:
> >> Do you plan to commit this check for syscall flags?
> > 
> > It's been committed since 15th May, but as it's the only fix I have
> > queued up (and my focus has been elsewhere) it hasn't been sent yet.
> > It's been in linux-next for a while now.
> 
> Ok, thanks, I see it there.
> 
> How about the same fix for arm64?  I see you don't work much on that, so
> should I post that patch myself?

Yes, please. If you post your arm64 patch with me and Catalin on Cc, then
we'll make sure it gets queued up.

Thanks,

Will

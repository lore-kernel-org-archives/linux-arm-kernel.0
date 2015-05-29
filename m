From: jistone@redhat.com (Josh Stone)
Date: Fri, 29 May 2015 13:13:18 -0700
Subject: arm syscall fast path can miss a ptrace syscall-exit
In-Reply-To: <20150528103710.GZ2067@n2100.arm.linux.org.uk>
References: <5554F3E4.8020307@redhat.com>
 <20150514193553.GD2067@n2100.arm.linux.org.uk> <55550EBA.3050708@redhat.com>
 <5564F5E0.7080108@redhat.com> <20150528103710.GZ2067@n2100.arm.linux.org.uk>
Message-ID: <5568C85E.8050509@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2015 03:37 AM, Russell King - ARM Linux wrote:
> On Tue, May 26, 2015 at 03:38:24PM -0700, Josh Stone wrote:
>> Hi Russell,
>>
>> Do you plan to commit this check for syscall flags?
> 
> It's been committed since 15th May, but as it's the only fix I have
> queued up (and my focus has been elsewhere) it hasn't been sent yet.
> It's been in linux-next for a while now.

Ok, thanks, I see it there.

How about the same fix for arm64?  I see you don't work much on that, so
should I post that patch myself?

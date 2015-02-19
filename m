From: sasha.levin@oracle.com (Sasha Levin)
Date: Thu, 19 Feb 2015 05:56:45 -0500
Subject: stand-alone kvmtool
In-Reply-To: <54DDD465.3050300@arm.com>
References: <54DDD465.3050300@arm.com>
Message-ID: <54E5C16D.3060109@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2015 05:39 AM, Andre Przywara wrote:
> Hi,
> 
> as I found it increasingly inconvenient to use kvmtool[1] as part of a
> Linux repository, I decided to give it a go and make it a stand-alone
> project. So I filtered all the respective commits, adjusted the paths in
> there (while keeping authorship and commit date, of course) and then
> added the missing bits to let it compile without a kernel tree nearby.
> The result is now available on:
> 
> git://linux-arm.org/kvmtool.git
> http://linux-arm.org/kvmtool.git

Hi Andre,

What inconvenience is caused by having it sit inside the kernel tree
beyond an increased requirement in disk space?

Moving it out will make us lose all the new features and bug fixes we
gain from using the kernel code directly rather than copying it once
in a while.

With your suggestion we'll end up needing something that copies stuff
from the kernel into that standalone tree, just like what qemu does.


Thanks,
Sasha

From: nicolas.dichtel@6wind.com (Nicolas Dichtel)
Date: Fri, 13 Jan 2017 17:08:34 +0100
Subject: [PATCH v3 4/8] x86: stop exporting msr-index.h to userland
In-Reply-To: <25483.1484322229@warthog.procyon.org.uk>
References: <1484304406-10820-5-git-send-email-nicolas.dichtel@6wind.com>
 <3131144.4Ej3KFWRbz@wuerfel>
 <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
 <25483.1484322229@warthog.procyon.org.uk>
Message-ID: <dd826bc7-e1ef-be29-e0c3-692afb346036@6wind.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 13/01/2017 ? 16:43, David Howells a ?crit :
>> -header-y += msr-index.h
> 
> I see it on my desktop as /usr/include/asm/msr-index.h and it's been there at
> least four years - and as such it's part of the UAPI.  I don't think you can
> remove it unless you can guarantee there are no userspace users.
I keep it in the v2 of the series, but the maintainer, Borislav Petkov, asks me
to un-export it.

I will follow the maintainer decision.


Regards,
Nicolas

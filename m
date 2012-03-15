From: dhowells@redhat.com (David Howells)
Date: Thu, 15 Mar 2012 22:25:15 +0000
Subject: [PATCH] Fixes after disintegration of asm/system.h for ARM
In-Reply-To: <4F626AFF.1060501@samsung.com>
References: <4F626AFF.1060501@samsung.com>
 <20120315212619.31098.94700.stgit@warthog.procyon.org.uk>
Message-ID: <463.1331850315@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim <kgene.kim@samsung.com> wrote:

> >   arch/arm/mach-s3c2410/s3c2410.c              |    1 +
> >   arch/arm/mach-s3c2412/s3c2412.c              |    1 +
> >   arch/arm/mach-s3c2416/s3c2416.c              |    1 +
> >   arch/arm/mach-s3c2440/s3c244x.c              |    1 +
> >   arch/arm/mach-s3c2443/s3c2443.c              |    1 +
> 
> Just note, above files have been moved into mach-s3c24xx/

Thanks.  Hopefully GIT should handle that.

David

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Sep 2009 17:31:11 +0100
Subject: [PATCH] arch/arm/common/vic.c: code reorganization
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901D41EF4@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901CBF46D@mi8nycmail19.Mi8.com>
	<63386a3d0909180155s3032d6e7jc18b36e1b62a288f@mail.gmail.com>
	<BD79186B4FD85F4B8E60E381CAEE190901D41EF4@mi8nycmail19.Mi8.com>
Message-ID: <20090918163111.GA2284@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2009 at 12:23:26PM -0400, H Hartley Sweeten wrote:
> The only thing I can think of that might keep it from applying is if
> your -next tree has the patch you posted to include device.h in the
> driver.  That patch is of course needed so that the file will build
> but I have not seen anything about someone picking it up yet.  That
> patch will fuzz mine by one line.
> 
> I was hoping your patch would get merged soon to fix the build.  I
> was then planning on rebasing this patch.  I just wanted to get this
> out now for any comments.

The patch adding device.h to vic.c is queued for this Saturday's push.

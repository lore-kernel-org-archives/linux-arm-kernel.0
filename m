From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Feb 2013 10:37:06 +0000
Subject: [RFC] Kbuild support for ARM FIT images
In-Reply-To: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com>
Message-ID: <20130221103705.GB17852@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 20, 2013 at 07:37:10PM -0600, Joel A Fernandes wrote:
> Hello,
> I've been spinning some work-in-progress patches for FIT build support
> in the kernel.
> With the move to multiplatform support on OMAP, I feel it is a good
> time to add  FIT support, also looking at the proliferating number of
> dtbs, as it is a nice way

I'm not looking to add yet another crappy uboot image format to the kernel
just for the hell of uboot.

And don't think that the dtbs in the kernel are going to stay there.  The
longer term plan is for them to end up in an external git tree, entirely
separate from the kernel source.  So anything that ties them with the
kernel build process will ultimately have to be removed again.

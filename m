From: paul.s.schilling@gmail.com (Paul Schilling)
Date: Fri, 6 Apr 2012 13:12:59 -0500
Subject: Samsung S3C2416 framebuffer corruption.
Message-ID: <CAC=G6sww1eUv=jo6AftxDn5wPsoWG=G+VF7dJYRU6OAxTPHt1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am having issues with the frame buffer on the S3C2416.  The issue
that I seem to be having is that certain colors especially for some
reason X console screens that are white with black font corrupt the
frame buffer.  It appears that LCD lines get shoved down a number of
lines and will even get wrapped back around from the  bottom to the
top.  I have a Qt app with a solid blue background with no problems.
With this bug the screen is constantly jittering,  I have seen some
times in X where the pointer will cause this screen corruption across
the entire row for as tall as the pointer is on screen.

Second in Linux what would it take to get some video acceleration
support from the 2D accelerator in the S3C2416.  I know there has been
some work done recently on the exynos platform.  I know that the
exynos has 3D accelerator also.

Thanks,
Paul

From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 15 Jul 2013 10:36:58 +0200
Subject: v3.10 - big endian core support
In-Reply-To: <51E3ACD0.8040209@codethink.co.uk>
References: <CALicx6u89THSiRa4FzGZrcoG8q+o_BD8qVEC4CYXEjPUVK_fJw@mail.gmail.com>
 <20130712134726.0a909165@skate> <51DFEF75.8080600@codethink.co.uk>
 <20130714215325.GB7382@mudshark.cambridge.arm.com>
 <51E3ACD0.8040209@codethink.co.uk>
Message-ID: <20130715103658.068ac6b7@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ben Dooks,

On Mon, 15 Jul 2013 09:03:28 +0100, Ben Dooks wrote:

> > As for building a Thumb-2 kernel; just enable the option in menuconfig and
> > you're done. The compiler should "do the right thing".
> 
> I can build it, I just don't have the time and hardware to give it a
> test at the moment. However it seems that changing to using 'rev16'
> instead of 'rev'. I will make the necessary changes and get this ready
> to go.

I am willing to give some testing to early patches, if needed. Do not
hesitate to send me things to test.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

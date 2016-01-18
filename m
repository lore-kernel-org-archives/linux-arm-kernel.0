From: uphienough@gmail.com (Ache Keim)
Date: Mon, 18 Jan 2016 10:41:51 +0900
Subject: limitation for module loading area of 16MB(or 14MB except pkmap) is
 still there?
Message-ID: <CADf3fxZ+P1Ka6hWkEtJGqDBeZMutKa+XiOM09ELuBcNYeWx2dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've seen large kernel module having size of 8MB or more and I failed
to loading 2 such modules.
and found out that my kernel has only 14MB for modules.

After googling I've got the information that the limitation of range
of direct jump impose this limitation of module loadable areas
position and size.

Is this still true? If then, do you think this 14MB area is enough to
hold all kernel modules?

Actually I was surprised and wondering this 14MB is large enough to
loading multiple kernel modules. (even in spite of  64MB module size
limitation has been removed.)

Thanks,
Hans

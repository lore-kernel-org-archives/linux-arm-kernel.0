From: anish198519851985@gmail.com (anish singh)
Date: Sun, 23 Mar 2014 15:31:23 -0700
Subject: Disabling gcc inline operation
Message-ID: <CAK7N6vrgnNdFvo8as+DrhXurxP+SexN9gi3WFrX_SCO9i2Ybyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many a time i have got a crash and it is difficult
to find out the exact function which crashed
because the crash stack doesn't show the "real"
function because gcc inlines many functions when
ever it desires or when it optimizes for speed.

So i don't want gcc to inline any function instead
just call the function so that i can see the crash
stack of each function called. I just want to do
this for debugging. Please let me know how can
i do that?

What switch command to pass to gcc in the make
of linux kernel?

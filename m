From: b.hutchman@gmail.com (Brian Hutchinson)
Date: Mon, 15 Dec 2014 15:33:50 -0500
Subject: How much flash space should I reserve for device tree blobs?
Message-ID: <CAFZh4h_74LY=w7gV=zNAC0ssRFgrh1DduPmZ2c+HenbztRRc-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reflecting back on the famous quote of "Nobody needs more than 640K",
how much space should I reserve in flash to 'future proof' my MTD map
in regards to dtb's?

Looking at the current flavors of dtb's built in a recent mainline
kernel, the biggest one I see is 66K.

How big do you all see these getting?  I know, it's probably a loaded
question.  Would just like to bounce this off the list as a sanity
check ... measure twice cut once kind of thing.

Regards,

Brian

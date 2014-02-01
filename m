From: olof@lixom.net (Olof Johansson)
Date: Fri, 31 Jan 2014 21:18:09 -0800
Subject: arm-soc for-next branch reset;
 not all late contents made it in for 3.14
Message-ID: <CAOesGMgadL7eK6dhpMU2z2V8ph9TFOoS1TUgFoPtqG5XeCU_DA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've reset for-next (old contents is in for-next2), and merged in our
first fixes branch into it.

Unfortunately not all late/* branch contents made it in, in particular
some of the stuff we had in late/drivers. If your patches are among
these, please send us fresh pull requests past -rc1.

As far as patches go, we currently should be in sync with what's come
in, and I've made a pass to try to catch any straggling ones. Please
take a look and let us know if we've missed any of your code that we
had queued.

We're also including a few defconfig and dts changes in this batch of
fixes, but we hope to not continue doing too much of that from here on
out. So if you think you need any, let us know sooner rather than
later.

Besides that, we're back to business as usual. :)


-Olof

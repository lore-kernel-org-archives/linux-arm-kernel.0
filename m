From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Sep 2012 14:08:11 +0100
Subject: [RFC PATCH 4/6] ARM: kernel: update cpu_suspend code to use
 cache LoUIS operations
In-Reply-To: <CAMQu2gw0650GoDrsnrNvjYWxpUeo-ywuFBw36m=7tp+mpNUG5w@mail.gmail.com>
References: <1347531651-28218-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1347531651-28218-5-git-send-email-lorenzo.pieralisi@arm.com>
 <20120913125347.GD2470@linaro.org>
 <CAMQu2gw0650GoDrsnrNvjYWxpUeo-ywuFBw36m=7tp+mpNUG5w@mail.gmail.com>
Message-ID: <20120913130811.GJ28448@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2012 at 06:31:35PM +0530, Shilimkar, Santosh wrote:
> In the series, there is patch "[PATCH 3/6]" which adds an
> API which let you operate on a specific level.

Which is introduced but as far as I can see, is never used in the patch
set.  Therefore, it shouldn't be introduced.

We've been here before many many many times, where people introduce stuff
into the kernel, and then they never get around to using the damned stuff.
It's happened far too many times to permit on a "but I will use it in the
future" kind of arguments.

If you're going to introduce something new, include the users in the patch
set, or don't bother submitting the new function in the vague hope that
some day it will get used.

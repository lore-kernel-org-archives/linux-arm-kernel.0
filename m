From: khilman@ti.com (Kevin Hilman)
Date: Mon, 12 Mar 2012 15:28:42 -0700
Subject: [PATCH v3 00/13] gpio/omap: Some more driver cleanup and fixes
In-Reply-To: <CAC83ZvJDfDBcRU1isYaxRe-fWN8F2+QW6W5EeWWuTRcFBGpYNg@mail.gmail.com>
 (Tarun Kanti DebBarma's message of "Tue, 13 Mar 2012 01:57:03 +0530")
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
 <878vj5y7iv.fsf@ti.com>
 <CAC83Zv+8AjCHBOJbtvSQS-URvCE5Xm9oPk9_X7h4Kz7FZ_7Otw@mail.gmail.com>
 <CAC83ZvJKS34Py6vVtk_Si9q3A-9CVN6v4ixNM+HJ37AATcGNPA@mail.gmail.com>
 <CAC83ZvJDfDBcRU1isYaxRe-fWN8F2+QW6W5EeWWuTRcFBGpYNg@mail.gmail.com>
Message-ID: <87vcm9v4h1.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

[...]

>>> Oops... I am sorry.
>>> I was in the process of updating the branch with latest comments after
>>> base-lining on Grant's:
>>> git://git.secretlab.ca/git/linux-2.6.git
>>> Branch: gpio/next
>>> Because this has all the gpio changes including Benoit's latest gpio
>>> devicetree changes.
>>> Should I go ahead?
>> Anyways, for the time being I am updating on top of your changes as before.
>> You should be able to see the branch shortly.
> Please note that the branch has your following patch:
> gpio/omap: fix wakeups on level-triggered GPIOs

Please be sure to Cc the GPIO maintainer (added now.)

Grant can we consider your gpio/next a stable baseline for further
GPIO fixes?

If so, Tarun, please base your branch there.  Otherwise, continue to use
my for_3.4/gpio/runtime-pm-cleanup, but please test it by merging with
the gpio/next branch.

Thanks,

Kevin

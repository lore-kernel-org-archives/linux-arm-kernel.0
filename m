From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 24 Sep 2013 11:17:47 +0100
Subject: Vexpress config
In-Reply-To: <CAHSGOuuLx6Cfuq5otV+Jd1ZvdJ-Hg-an_3A2XXNik-AUsw+QVw@mail.gmail.com>
References: <CAHSGOuusvazUFFAAraCZmQgXr8LvwdV4zess=KsEMsCtbg0y2A@mail.gmail.com>
 <CAHSGOus7VsJh+-mpxOWeeyqfsB4jNYiG-vwRirFaJh39c3Heww@mail.gmail.com>
 <1379323515.3998.12.camel@hornet>
 <CAHSGOusEZtdVwnKo7fxLKQKnVVde1FRHtruRYG9BkBpNB6r3ag@mail.gmail.com>
 <1379601512.3347.26.camel@hornet>
 <CAHSGOuuLx6Cfuq5otV+Jd1ZvdJ-Hg-an_3A2XXNik-AUsw+QVw@mail.gmail.com>
Message-ID: <1380017867.3316.7.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2013-09-22 at 11:07 +0100, melwyn lobo wrote:
> 1. ARM pl11x CLCD driver fails (only clcd, whereas other peripherals
> initialization is OK) :
> 
> clcd-pl11x: probe of 1c1f0000.clcd failed with error -22
> 
> On running prebuilt images from linaro releases site, they work just
> fine on CA15x4 with four clean TUX logos on the simulated CLCD screen.

This is - unfortunately - expected. The CLCD driver in main line does
not speak Device Tree yet. Linaro kernels carry some early version of
patches changing that. The latest version is being discussed here:

http://thread.gmane.org/gmane.linux.drivers.devicetree/44721

> 2. I don't have an initrd which boot till shell prompt. It could just
> be a problem with my image but I would really like to have a clean
> working initrd to start with. (Don't want to use Linaro's becuase they
> boot till Android home screen)

No offence meant, but this is already your problem ;-) Definitely
nothing to do with Versatile Express.

Pawe?

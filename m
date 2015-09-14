From: tony@atomide.com (Tony Lindgren)
Date: Mon, 14 Sep 2015 12:02:36 -0700
Subject: mysterious crashes on OMAP5 uevm
In-Reply-To: <20150914121248.GD21098@n2100.arm.linux.org.uk>
References: <CANOLnOO3NdK1r1jZQtS=TcHEE7SQwhGHh0YsqqoCJpFW3NO05Q@mail.gmail.com>
 <20150908143810.GD4215@atomide.com>
 <CANOLnOODjTaBcL1QzAm7o4YOB=_P-s7JYovu6fhNSqJSV2Bq+Q@mail.gmail.com>
 <20150908210708.GH4215@atomide.com>
 <E0068B56-0DEE-4E2F-94CF-DB104AE16D63@goldelico.com>
 <20150910083026.GA21098@n2100.arm.linux.org.uk>
 <CANOLnOM-PYcAL=f4rgucfdWZ1+U3HkP34bfwrKP4Rob+J6iTfw@mail.gmail.com>
 <20150911140306.GB21098@n2100.arm.linux.org.uk>
 <20150914121248.GD21098@n2100.arm.linux.org.uk>
Message-ID: <20150914190236.GV4215@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [150914 05:16]:
> On Fri, Sep 11, 2015 at 03:03:07PM +0100, Russell King - ARM Linux wrote:
> > 
> > Merely changing __LINUX_ARM_ARCH__ >= 7 to >= 6 should fix the problem,
> > and I doubt there's any ARMv6 non-T2 systems out there that would be
> > affected by clearing the IT state bits.
> 
> Please test the following patch:

While we're waiting for Grazvydas to test.. Looks good to me:

Acked-by: Tony Lindgren <tony@atomide.com>

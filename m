From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 04 Jul 2014 12:12:22 +0200
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140704092519.GC21766@n2100.arm.linux.org.uk>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <20140704085745.GB16404@arm.com>
 <20140704092519.GC21766@n2100.arm.linux.org.uk>
Message-ID: <7255305.EKPTbfD3OE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 July 2014 10:25:19 Russell King - ARM Linux wrote:
> Moreover, when you download from the play store, you are only presented
> with the version which is appropriate for your device - when you buy a
> new device, and you re-fetch your apps, you don't get the same version
> that you've had on previous device if there's one more appropriate for
> your new device.

This is certainly true, but at the same time the device makers have
a valid interest in making as many apps as possible be enabled without
requiring a recompile. If it becomes known that device A supports 90%
of the popular apps while device B only supports 70% of the same apps
(until they get recompiled), the decision whether to put emulation in
or not is more about maximizing revenue than about theoretical
correctness.

	Arnd

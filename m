From: martinwguy@gmail.com (Martin Guy)
Date: Thu, 10 Jun 2010 22:29:12 +0100
Subject: Context Switching is Broken
In-Reply-To: <148780.29764.qm@web51806.mail.re2.yahoo.com>
References: <503171.97993.qm@web51806.mail.re2.yahoo.com>
	<20100610140136.GA32362@n2100.arm.linux.org.uk>
	<20100610142015.GC32362@n2100.arm.linux.org.uk>
	<AANLkTimeZ6xawjcYfVDohBFcMbbLlC3h2gDs91CyGcBX@mail.gmail.com>
	<148780.29764.qm@web51806.mail.re2.yahoo.com>
Message-ID: <AANLkTilfwCVpr7JrLlWLIXV1DtAGZyRpvDd_8W-qfq5t@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hermann

While context switching works fine - any Unix system would have a hard
time working without it - these four esoteric system calls are not
implemented in the ARM port of Linux. If you'd like to modify the
linux source code to implement them, I'm sure the community would be
happy to review the patches for inclusion in the next version of the
kernel.

They seem to be implemented on x86 processors if you need them.

    M

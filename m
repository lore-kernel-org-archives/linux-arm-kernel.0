From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Sep 2011 10:01:22 +0100
Subject: [RFC PATCH 2/3] ARM: iwmmxt: Port problematic iwmmxt support
	code to v7/Thumb-2
In-Reply-To: <20110908085800.GB2070@arm.com>
References: <1315411158-17479-1-git-send-email-dave.martin@linaro.org>
	<1315411158-17479-3-git-send-email-dave.martin@linaro.org>
	<CAMPhdO927WucyKRjbj69ahD7xmu-7L-Vt1AkGe1yZsmXv4YS8A@mail.gmail.com>
	<1790084.iooACCopcX@wuerfel> <20110908085800.GB2070@arm.com>
Message-ID: <20110908090122.GC14953@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2011 at 09:58:00AM +0100, Dave Martin wrote:
> I take pj4 and older platforms can never be built in the same kernel?
> Otherwise, this approach is totally broken anyway-- we'll generate code
> which won't run on some of the kernel's supported platforms.

We have a well enforced split between ARMv5 and older CPUs, and ARMv6
and later CPUs.

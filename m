From: peter.maydell@linaro.org (Peter Maydell)
Date: Fri, 18 Jul 2014 16:52:37 +0100
Subject: [PATCHv4 5/5] arm64: cpuinfo: print info for all CPUs
In-Reply-To: <20140718135738.GA17328@leverpostej>
References: <CAFEAcA-_GawEimGS4q8=C7BK6gLzSA+xVSUtLFkUS5=Mf8syBw@mail.gmail.com>
 <53C7A980.8050601@arm.com> <20140717105415.GI21153@arm.com>
 <CAFEAcA8wZ9z8+0Q-2D_B3tkuQnksdWFeWEAadkHyB72oS6ae=A@mail.gmail.com>
 <20140717123533.GJ21153@arm.com>
 <CAFEAcA_ZXDDRycNVXmw1FSgRFiPgtB_2qqe-ioj91jMeBJR7PQ@mail.gmail.com>
 <20140717171058.GM18203@arm.com> <20140717172858.GD4844@arm.com>
 <20140718092744.GA19850@arm.com> <20140718095311.GA1818@arm.com>
 <20140718135738.GA17328@leverpostej>
Message-ID: <CAFEAcA-jdVxgUY03j12HDWzKwtVaxsmL-AarD5QyNb1jmYEa2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 July 2014 14:57, Mark Rutland <mark.rutland@arm.com> wrote:
> Comments are added to guide userspace developers in the right direction
> (using the hwcaps provided in auxval). Hopefully where userspace
> applications parse /proc/cpuinfo rather than using the readily available
> hwcaps, they limit themselves to reading said first line.

Comments in the kernel sources aren't going to guide
anybody except kernel developers. I was expecting from
this commit message that you were going to emit actual
comments in /proc/cpuinfo...

-- PMM

From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 20 Feb 2015 11:49:22 -0200
Subject: Announce: rmk's nightly builder gets ARM64 support
In-Reply-To: <20150220133806.GG8656@n2100.arm.linux.org.uk>
References: <20150219171220.GA8656@n2100.arm.linux.org.uk>
 <20150219183444.GB8656@n2100.arm.linux.org.uk>
 <20150220092003.GB31692@arm.com>
 <CAKv+Gu_5fOinMVYbk99unmEDSqCF3Z7QdXiQTw0VrrWW16Oc6w@mail.gmail.com>
 <20150220094035.GE8656@n2100.arm.linux.org.uk>
 <20150220102009.GF8656@n2100.arm.linux.org.uk>
 <CAOMZO5Aqx_SQ1oaML=hiVzzJMJ2bNTAsjk-dWFLkETaV4_JO+A@mail.gmail.com>
 <20150220133806.GG8656@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5BgrWGciKt0pjpbtX4wP0CgWWN39BcSjnSD89MxKEpBCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 11:38 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> From what I can see, this doesn't _build_ a compiler.  It grabs
> gcc-linaro-aarch64-linux-gnu-4.9-2014.08_linux.tar.xz from
> http://releases.linaro.org/14.08/components/toolchain/binaries
> and installs that - which contains a load of binaries.

That's correct. It uses the pre-built binaries from Linaro.

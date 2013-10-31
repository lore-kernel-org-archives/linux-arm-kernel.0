From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 31 Oct 2013 19:23:30 +0000
Subject: [PATCH 2/4] ARM: msm: Remove 7x00 support
In-Reply-To: <20131031173506.GA31722@fifo99.com>
References: <1382993006-27359-1-git-send-email-davidb@codeaurora.org>
 <1382993006-27359-3-git-send-email-davidb@codeaurora.org>
 <20131029132043.GA28165@fifo99.com>
 <CAOesGMhg8HN4Su9FXSeoAgmH6NVKXW+wmnreUvWH+1G6GWkkaA@mail.gmail.com>
 <87ob66nyqc.fsf@linaro.org> <20131030232412.GA10229@fifo99.com>
 <8738nhnz4s.fsf@linaro.org> <20131031173506.GA31722@fifo99.com>
Message-ID: <20131031192330.GG16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 10:35:06AM -0700, Daniel Walker wrote:
> ARM and the sub-architectures is already confusing I don't think we need
> to start compounding the problem by allowing random whatever-you-want
> sub-directories from every sub-architecture.

Confusing?

I'm not sure about that.  It's actually really simple from my perspective:

arch/arm - the ARM 32-bit architecture

arch/arm/mach-* - support for a single SoC or a group of similar SoCs

arch/arm/plat-* - common support for a set of dissimilar SoCs which want
	to share code between themselves

How is that confusing?

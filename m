From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 16 Feb 2011 14:14:30 -0800
Subject: [PATCH 2/2] ARM: remove the 4x expansion presumption
	while	decompressing the kernel
In-Reply-To: <alpine.LFD.2.00.1102161707180.14920@xanadu.home>
References: <1297892343-29064-1-git-send-email-nico@fluxnic.net>	<1297892343-29064-2-git-send-email-nico@fluxnic.net>	<4D5C47C7.6010006@codeaurora.org>
	<alpine.LFD.2.00.1102161707180.14920@xanadu.home>
Message-ID: <4D5C4C46.1060505@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/16/2011 2:11 PM, Nicolas Pitre wrote:
> On Wed, 16 Feb 2011, Stephen Boyd wrote:
>
>> On 02/16/2011 01:39 PM, Nicolas Pitre wrote:
>>> -LDFLAGS_vmlinux := --defsym zreladdr=$(ZRELADDR)
>>> +LDFLAGS_vmlinux += --defsym zreladdr=$(ZRELADDR)
>> What is this for?
> It replaces the assignment operator with an addition operator ?

Ah sorry, ignore me.

From: maz@misterjones.org (Marc Zyngier)
Date: Tue, 25 May 2010 19:09:13 +0200
Subject: [PATCH 2/2] ixp4xx/vulcan: add PCI support
In-Reply-To: <m3ochke5i5.fsf@intrepid.localdomain>
References: <1270931559-9414-1-git-send-email-maz@misterjones.org>
	<1270931559-9414-2-git-send-email-maz@misterjones.org>
	<m3ochke5i5.fsf@intrepid.localdomain>
Message-ID: <972e12f2334879228a443b21905389cd@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Fri, 16 Apr 2010 00:05:22 +0200, Krzysztof Halasa <khc@pm.waw.pl>
wrote:
> Marc Zyngier <maz@misterjones.org> writes:
> 
>> Add PCI support for the Vulcan board, supporting USB and CF ports.
>> The PC/104 bus (actually a hack on the second CarBus slot) is not
>> currently supported.
> 
> Thanks, I've applied both of them.

Krzysztof,

Is there any plan for this to be merged while the window is still opened?
I have some other patches that depend on these first two, but if it's going
to be delayed until 2.6.36, I'll simply repost the whole thing for review.

Cheers,

        M.
-- 
Who you jivin' with that Cosmik Debris?

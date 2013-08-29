From: broonie@kernel.org (Mark Brown)
Date: Thu, 29 Aug 2013 19:20:11 +0100
Subject: [PATCH 1/2] ARM: Dove: Add the audio devices in DT
In-Reply-To: <521F8CB3.5060407@gmail.com>
References: <20130828113459.48ecbb34@armhf> <521DCD33.2070008@gmail.com>
 <20130828121943.1c8327ca@skate> <521DD057.4040208@gmail.com>
 <20130829161217.GK10783@sirena.org.uk>
 <20130829163358.GS6617@n2100.arm.linux.org.uk>
 <20130829171210.GM10783@sirena.org.uk> <521F8CB3.5060407@gmail.com>
Message-ID: <20130829182010.GQ10783@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 29, 2013 at 08:02:27PM +0200, Sebastian Hesselbarth wrote:
> 
> it is referring the same differences Russell already mentioned. But I
> already came to the conclusion, that we don't need the information in
> the binding. For example, if you use that controller on Dove and you
> hook it up for SPDIF-in (which it hasn't), than I consider this a
> DT bug. No need to double-check that in the driver. From that p-o-v,
> please just let the current binding as is.

OK, great - none of these devices have any differences which are visible
only within the controller, they're all extra external interfaces?

> Thomas Petazzoni mentioned earlier, that the _usual_ procedure to
> name the compatibles is to pick the SoC that the IP appeared in first.
> But I am also fine with "marvell,mvebu-audio" and adding compatibles
> for dove or kirkwood _if_ we will ever need them.

Yeah, it doesn't make much difference either way so long as the base
name isn't utterly confusing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130829/45a71d28/attachment.sig>

From: broonie@kernel.org (Mark Brown)
Date: Thu, 5 Dec 2013 20:35:19 +0000
Subject: [PATCH 1/2] cpufreq: enable ARM drivers on arm64
In-Reply-To: <52A0DC28.1040001@gmail.com>
References: <1386202994-30784-1-git-send-email-robherring2@gmail.com>
 <1386202994-30784-2-git-send-email-robherring2@gmail.com>
 <20131205181606.GY29268@sirena.org.uk> <52A0DC28.1040001@gmail.com>
Message-ID: <20131205203519.GA29268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 02:03:52PM -0600, Rob Herring wrote:

> Will do, but I'm surprised we're at the point on arm64 of needing LSK.

ARMv8 isn't just for servers, and of course there's the desire to have
the software as ready as early as it can be!

> There's a couple of subsystems that need enabling. I've posted EDAC
> patches (need to send v3). cpuidle is another. Probably some more I
> haven't looked at.

Right, cpuidle is in progress - Lorenzo has been posting patches for
that:  

   http://lwn.net/Articles/574950/

There's some active work in the trace and debug area too.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131205/d2c54368/attachment.sig>

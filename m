From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 26 Sep 2015 17:15:57 +0200
Subject: [PATCH v3 00/26] ARM: pxa: magician: Rework HTC Magician support
In-Reply-To: <55FA4756.9080309@tul.cz> (Petr Cvek's message of "Thu, 17 Sep
 2015 06:53:42 +0200")
References: <55FA4756.9080309@tul.cz>
Message-ID: <87zj09fbyq.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> This patchset will clean, fix, optimize and add multiple devices,
> which can be found on the HTC Magician machine.
... zip ...
>  arch/arm/mach-pxa/include/mach/magician.h |  78 +--
>  arch/arm/mach-pxa/magician.c              | 907 +++++++++++++++++++++---------
>  2 files changed, 682 insertions(+), 303 deletions(-)

Ok Petr, that's way better.
This is how I see the next step :
 1) You fix the patch 1/26 and resend only that one, it's trivial whitespacing,
    no need to send another complete patchset
 2) I wait a week for Philip to ack all the patches I replied to (ie. all except
    patch 19/26 and 22/26)
 3) If Philipp doesn't NAK, then I'll queue all these patches to my next tree
    (git://github.com/rjarzmik/linux.git pxa/for-next)

Meanwhile, I'll have time to answer to patches 19 and 22. Next Sunday, I'll
reply once more that I have queued your patches (provided that you update patch
1/26), and you will be able to rebase on this tree, leaving at most 2 patches to
deal with.

Cheers.

-- 
Robert

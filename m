From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 31 May 2010 16:50:54 +0200
Subject: [GIT PULL] pxa: fixes for v2.6.34-rc1
In-Reply-To: <AANLkTikF62qGENmyl9mYKXZskVKb8pgD8f-t7G6PsLxo@mail.gmail.com>
References: <AANLkTillgu4x49AMo9f6NMmmZvoMQRFaenfwi9d62W__@mail.gmail.com>
	<4C036207.5070701@canonical.com>
	<AANLkTikF62qGENmyl9mYKXZskVKb8pgD8f-t7G6PsLxo@mail.gmail.com>
Message-ID: <201005311650.54729.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Po 31. kv?tna 2010 09:42:59 Eric Miao napsal(a):
> On Mon, May 31, 2010 at 3:15 PM, Bryan Wu <bryan.wu@canonical.com> wrote:
> > Just a minor thing, the subject of this email should be "[GIT PULL] pxa:
> > fixes for v2.6.35-rc1"
> 
> Ah right, it was popped out with gmail's auto completion, which is smart
> doing a good job at most times, but apparently not always.

Didn't you miss the Z2 patches possibly? There were for the same thing (wm8750 
and battery ... I'll resend). Of course, they'll go through later.
> 
> > -Bryan
> > 
> > On 05/31/2010 12:25 PM, Eric Miao wrote:
> >> The following changes since commit
> >> 67a3e12b05e055c0415c556a315a3d3eb637e29e: Linus Torvalds (1):
> >>         Linux 2.6.35-rc1
> >> 
> >> are available in the git repository at:
> >> 
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git
> >> fix
> >> 
> >> Marek Vasut (1):
> >>       [ARM] pxa/spitz: Correctly register WM8750
> >> 
> >> Tobias Klauser (1):
> >>       [ARM] pxa/palmtc: storage class should be before const qualifier
> >> 
> >>  arch/arm/mach-pxa/palmtc.c |    4 ++--
> >>  arch/arm/mach-pxa/spitz.c  |    3 +++
> >>  sound/soc/pxa/spitz.c      |   36 ------------------------------------
> >>  3 files changed, 5 insertions(+), 38 deletions(-)
> >> 
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel at lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

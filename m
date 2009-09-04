From: jassisinghbrar@gmail.com (jassi brar)
Date: Fri, 4 Sep 2009 23:27:48 +0900
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <20090904134121.GB1576@sirena.org.uk>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<20090902121158.GU32606@prithivi.gnumonks.org>
	<1b68c6790909020644k757827f4kf590779f384ceccb@mail.gmail.com>
	<20090902144700.GD4012@sirena.org.uk>
	<1b68c6790909021738o3037c9dcve6699a7b272f6742@mail.gmail.com>
	<20090903121410.GC2954@sirena.org.uk>
	<1b68c6790909030639i55b7f18dy6c2961a2830e4862@mail.gmail.com>
	<20090903151812.GE2954@sirena.org.uk>
	<1b68c6790909031808n5bb06987yfe06b3438b1d05b0@mail.gmail.com>
	<20090904134121.GB1576@sirena.org.uk>
Message-ID: <1b68c6790909040727j7b87fb9y71e89e9c99737bd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 4, 2009 at 10:41 PM, Mark Brown<broonie@sirena.org.uk> wrote:
> If someone has modified the hardware then they will most likely want to
> produce a new machine driver anyway. ?If someone is interested in
> evaluating the various configurations (probably with the view to
> producing their own board) they can easily modify the source code.
> With a Kconfig choice they're going to have to rebuild the kernel to
> change configurations anyway.

I am afraid we are not able communicate our ideas clear enough, maybe
b'coz am a bit slow
or maybe i am wrong altogether. Let us communicate in code.
Gimme some time to come up with code for 6410 and maybe then i cud
better understand ur feedback.
Btw, i am preparing patches against your sound-2.6 tree. Please tell
if that is improper.


Let us let this thread take its intended course -- Suggestions of
maintainers as to how
we, at Samsung, cud involve in mainline support for Samsung SoCs.

AUDIO:-
   As one of the maintainer of Samsung SoC audio part, please tell
which task shud be my priority towards
enabling better audio support for 6410(and other newer SoCs too) in mainline.

SPI:-
  Soon after audio, my plan is to submit the SPI driver with support
for DMA, Multi-CS, MODE-0,1,2,3
FullDuplex tested with MMC over SPI.

OTHERS:-
  Maintainers may pitch in here to list TODOs for other 6410 drivers.

From: lkundrak@v3.sk (Lubomir Rintel)
Date: Fri, 12 Oct 2018 19:45:09 +0200
Subject: MMP platform maintenance status
Message-ID: <77f3a88e351311b8b623490c9badf630b7fd66b2.camel@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

for the last couple of months I've received no response from the
maintainers of the MMP platform. There's 31 patches in my queue now:

https://lore.kernel.org/patchwork/bundle/lkundrak/MMP2/

While most of them are enhancements, without some the mmp2 support is
too broken to boot (at least the device-tree based platform).

The MAINTAINERS entry also seems outdated:

  T:      git git://github.com/hzhuang1/linux.git
  T:      git git://git.linaro.org/people/ycmiao/pxa-linux.git

The first repository got no activity for 6 years or so, while the other
one is gone:

  $ git fetch git://git.linaro.org/people/ycmiao/pxa-linux.git
  fatal: remote error: access denied or repository not exported: /people/ycmiao/pxa-linux.git

I'm wondering -- is there some way to get my changes in?  Could it get
in via linux-arm if it got reviews/acks? Would someone, ideally with a
MMP2 datasheet, be kind enough to look at the patches and provide
feedback?

Is help with maintenance of MMP2 needed? Perhaps I could help? (Though
maybe someone would need to slip the data sheet under my door.)

Thanks,
Lubo

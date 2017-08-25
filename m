From: baruch@tkos.co.il (Baruch Siach)
Date: Fri, 25 Aug 2017 13:44:18 +0300
Subject: [RESEND PATCH 1/1] arm64: dts: Add Variscite DART-SD410
 Evaluation board dts
In-Reply-To: <CAP6K80Sj9=im4CpXTAL+oR6XLmiBQYPeNMmvpC6v2W0xOP-j4g@mail.gmail.com>
References: <014701d31418$8e419670$aac4c350$@variscite.com>
 <20170818203505.GB4042@hector.attlocal.net>
 <CAP6K80Sj9=im4CpXTAL+oR6XLmiBQYPeNMmvpC6v2W0xOP-j4g@mail.gmail.com>
Message-ID: <20170825104418.fb7thsfukgh3im2k@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leonid,

On Wed, Aug 23, 2017 at 08:44:56PM +0300, Leonid Segal wrote:
> Thank you very much for the tips.
> I have updated the documentation and schematics of our web site.
> I also tried to implement all other fixes, but seems that I cannot file the git
> you are talking about.
> The patches i sent were done to:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> and there is no -next branch.
> I tried to check out the linaro git:
> http://git.linaro.org/landing-teams/working/qualcomm/kernel.git
> there is a -next branch, but the USB section is in old format.
> 
> I tried to complile the latest version from
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> the usb there in new format, but nothing works (even LEDS) on Dragonboard too.
> So, I think I am missing something global on the way.
> 
>    If you can help me with it, I will appreciate it.

The linux-next tree is at [1]. Stephen Rothwell generates this tree on a daily 
basis semi-automatically from subsystem maintainers branches that feed the 
-next tree. Read more about it in the linux-next web page[2]. The branch that 
feeds the arm64 changes is for-next/core[3]. See the full list in the 
Next/Trees file in the -next tree.

Hope this helps,
baruch

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

[2] https://www.kernel.org/doc/man-pages/linux-next.html

[3] git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux#for-next/core

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

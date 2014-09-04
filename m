From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 04 Sep 2014 12:05:05 +0200
Subject: [PATCH 11/19] ARM: S5PV210: Remove support for board files
In-Reply-To: <53C675E4.4020502@samsung.com>
References: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
 <1404496099-26708-12-git-send-email-t.figa@samsung.com>
 <1405505072.4408.17.camel@x220> <53C675E4.4020502@samsung.com>
Message-ID: <1409825105.5546.91.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-07-16 at 14:53 +0200, Tomasz Figa wrote:
> I believe that both sound card drivers for Goni and Aquilla could be
> replaced with simple cards in DT, so I'll send a follow-up patch for this.

References to MACH_GONI and MACH_AQUILA can still be seen in v3.17-rc3
and next-20140903. Note that as consequence SND_SOC_GONI_AQUILA_WM8994
can not be set anymore.

> Most likely the same is the case for SMDK boards, but they don't seem to
> have any active users (see cover letter for more details), which means
> that probably they could be simply dropped from
> sound/soc/samsung/Kconfig in another follow-up patch.

Ditto for MACH_SMDKC100, MACH_SMDKC110, and MACH_SMDKV210. Note that
here SND_SOC_SMDK_WM8580_PCM can not be set anymore.

(This is intended to be a gentile reminder. I hope it actually comes
across like that.)


Paul Bolle

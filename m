From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 27 Nov 2015 09:42:28 +0100
Subject: [PATCH v8 02/17] drm: bridge: analogix/dp: split exynos dp driver
 to bridge directory
In-Reply-To: <5657AFEC.60004@rock-chips.com>
References: <1446020143-32645-1-git-send-email-ykk@rock-chips.com>
 <1812354.kkj0DGG9mi@diego> <5657AFEC.60004@rock-chips.com>
Message-ID: <2318006.v6fLo6Azsc@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yakir,

Am Freitag, 27. November 2015, 09:20:44 schrieb Yakir Yang:
> Hi Heiko,
> 
> Thanks you for feedback, I do see some conflicts in Exynos Make/Kconfig
> file [02/17] and dtsi file [07/17] when I try to apply this series on
> 4.4-rc1
> branch.
> 
> Hmm... Due to I have update some patches to version 10 already, this
> series may be become harder to reviewed, should I just send the whole
> series out that update the version to v10.

yes, that might make sense, also because people are generally reluctant to 
fixup patches when simply reviewing/testing.


Heiko

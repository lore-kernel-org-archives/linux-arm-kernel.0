From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 12 Sep 2012 12:47:38 +0200
Subject: arm: mvebu: improve Kconfig options handling for pinctrl
In-Reply-To: <504F75BC.1070805@gmail.com>
References: <1347266386-16229-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347377834-19402-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <504F75BC.1070805@gmail.com>
Message-ID: <20120912124738.72a6c3cc@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Le Tue, 11 Sep 2012 19:32:44 +0200,
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> a ?crit :

> as the linux-arm-kernel is already on this discussion, I'll not remove
> it on this one. But with future RFC patches we should be more careful
> who the patch is sent to.

Since I wasn't sure you would take those patches, I thought sending to
LAKML and other parties was a good idea.

> I'd like to have pinctrl-mvebu patch set separated from this Kconfig
> patch set. Not because it doesn't fit but because I don't want to
> respin the pinctrl patch. Posting v3 without in-depth review of my
> own was a mistake. A final v4 will get offending patches right.

Well, in the end, you have to resend a new v4, so why not include those
patches? Without those patches, the pinctrl stuff is not usable on
370/XP, which is not so nice.

> For this patch set I will comment on the single patch emails.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

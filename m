From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 22 Aug 2013 07:20:05 -0700
Subject: [GIT PULL 3/5] ARM: imx: device tree changes for 3.12
In-Reply-To: <1376833688-24542-3-git-send-email-shawn.guo@linaro.org> (Shawn
 Guo's message of "Sun, 18 Aug 2013 21:48:06 +0800")
References: <1376833688-24542-1-git-send-email-shawn.guo@linaro.org>
 <1376833688-24542-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <87vc2xu7sa.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo <shawn.guo@linaro.org> writes:

> Olof, Kevin,
>
> The pull request depends on the previous one imx-soc-3.12.  Please take
> care of it.  Thanks.

It seems it also has a dependency on [GIT PULL 1/5] for the binding
changes to the weim bus?  (specifically patch "ARM: dts: i.MX27: Add
WEIM node" uses the updated binding, correct?)  Please try and describe
all the dependencies.

Also, since it's based on the previous pull where I asked for some
changes (dropping DEBUG_LL support) you'll need to respin this one as well.

Kevin

From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 13 Sep 2016 13:04:25 +0200
Subject: [PATCH v1 1/2] ARM: dts: add rockchip PX3 Evaluation board
In-Reply-To: <94379f31-00bb-4873-5a93-f6eeead55180@rock-chips.com>
References: <1473529249-6151-1-git-send-email-andy.yan@rock-chips.com>
 <1473529440-6202-1-git-send-email-andy.yan@rock-chips.com>
 <94379f31-00bb-4873-5a93-f6eeead55180@rock-chips.com>
Message-ID: <1473786122.FM2XgiQb2U@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

Am Dienstag, 13. September 2016, 18:06:12 CEST schrieb Andy Yan:
> Hi Heiko:
> 
>      Is there any further suggestion about this series?

nope, all fine. I've now applied both patches, after moving some minor stuff
around (alphabetical ordering etc). While it is in branches targeted at 4.9 it
may very well only make it into 4.10.

I've also dropped the stk3310 i2c node from both until the binding is figured
out and moved the px3 board binding to the px5 patch, so that we can sort
entries correctly but don't produce merge conflicts.

If you have time, please give it a final look:
https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/commit/?id=a55e2f1b7423ab8b1c3fefbac7ae752e8a4b7edc
https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/commit/?id=d42f818e056116237ac8b6a3f72e5bfc38681589


Heiko

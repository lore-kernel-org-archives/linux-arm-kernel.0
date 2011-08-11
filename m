From: dianders@chromium.org (Doug Anderson)
Date: Thu, 11 Aug 2011 14:04:17 -0700
Subject: [PATCH] i2c: tegra: fix possible race condition after tx
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04AEA24CFC@HQMAIL01.nvidia.com>
References: <1313093946-24559-1-git-send-email-dianders@chromium.org>
	<74CDBE0F657A3D45AFBB94109FB122FF04AEA24CFC@HQMAIL01.nvidia.com>
Message-ID: <CAD=FV=V5i1ZTGs24hPa2M-VDsr2EFL0_Co7xJf5m07TNbPsMDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 11, 2011 at 1:54 PM, Stephen Warren <swarren@nvidia.com> wrote:
> It's worth pointing out that this patch supersedes a previous attempt to fix
> the same problem, originally posted in https://lkml.org/lkml/2011/4/19/514,
> if I'm understanding correctly.

Yup, you're right.  :)  If people are interested, you can see some
discussion of the differences between the two patches on the Chromium
code review system: <http://gerrit.chromium.org/gerrit/5684>

-Doug

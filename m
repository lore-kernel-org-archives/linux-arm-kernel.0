From: gnurou@gmail.com (Alexandre Courbot)
Date: Wed, 17 Dec 2014 17:13:25 +0900
Subject: [PATCH] ARM: dts: tegra20: fix GR3D,
 DSI unit and reg base addresses
In-Reply-To: <1418397559-19646-1-git-send-email-digetx@gmail.com>
References: <1418397559-19646-1-git-send-email-digetx@gmail.com>
Message-ID: <CAAVeFuLPs8f1ZFT4JHTar1NRmb6rvYDv2i=pp-8LBwKEFw0sjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 13, 2014 at 12:19 AM, Dmitry Osipenko <digetx@gmail.com> wrote:
> Commit 58ecb23f64ee ("ARM: tegra: add missing unit addresses to DT") added
> unit address and changed reg base for GR3D and DSI host1x modules, but these
> addresses belongs to GR2D and TVO modules respectively. Fix it by changing
> modules unit and reg base addresses to proper ones.

Checked with the TRM, you are absolutely correct.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

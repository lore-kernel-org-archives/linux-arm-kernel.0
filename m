From: leoli@freescale.com (Li Yang)
Date: Fri, 4 Sep 2015 16:31:22 -0500
Subject: [PATCH v2 08/10] dts/ls2085a: Update Simulator DTS to add support
 of various peripherals
In-Reply-To: <1441350322-4671-2-git-send-email-bhupesh.sharma@freescale.com>
References: <1441350322-4671-1-git-send-email-bhupesh.sharma@freescale.com>
 <1441350322-4671-2-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <CADRPPNRzW7A-D+0Bg7ELT229zQ5VKrj1PAdv8Qq9qARGP_cwnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 4, 2015 at 2:05 AM, Bhupesh Sharma
<bhupesh.sharma@freescale.com> wrote:
> This patch updates the LS2085a simulator DTS to add support of various

LS2080...

> peripherals which are supported on the simulator platform and explicitly
> disables those which are yet not supported on the platform.

I don't know if there will be any people outside Freescale would get
this simulator.  If not, we should just remove this file.

>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts |   54 ++++++++++++++++++--
>  1 file changed, 49 insertions(+), 5 deletions(-)

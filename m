From: treding@nvidia.com (Thierry Reding)
Date: Mon, 9 Nov 2015 13:45:47 +0100
Subject: [PATCH v4] Tegra: DT: add device tree binding doc for QSPI
In-Reply-To: <562EB11D.5040706@wwwdotorg.org>
References: <1445898140-3561-1-git-send-email-twarren@nvidia.com>
 <562EB11D.5040706@wwwdotorg.org>
Message-ID: <20151109124545.GD23941@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 05:02:53PM -0600, Stephen Warren wrote:
> On 10/26/2015 04:22 PM, Tom Warren wrote:
> >This patch adds the device tree binding doc for the Tegra
> >QSPI controller on Tegra210.
> 
> Acked-by: Stephen Warren <swarren@nvidia.com>
> 
> (I assume if others approve the binding, Thierry will take it through the
> Tegra tree)

Do we have a kernel driver and hardware where this can be tested? I'm
slightly reluctant to merge a binding through the Tegra tree without a
driver that implements it.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151109/95353ee6/attachment.sig>

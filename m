From: sre@kernel.org (Sebastian Reichel)
Date: Sat, 10 Oct 2015 01:31:49 +0200
Subject: [PATCH v3 1/7] drm/vc4: Add devicetree bindings for VC4.
In-Reply-To: <1444426068-15817-2-git-send-email-eric@anholt.net>
References: <1444426068-15817-1-git-send-email-eric@anholt.net>
 <1444426068-15817-2-git-send-email-eric@anholt.net>
Message-ID: <20151009233148.GA31997@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 09, 2015 at 02:27:42PM -0700, Eric Anholt wrote:
> VC4 is the GPU (display and 3D) subsystem present on the 2835 and some
> other Broadcom SoCs.
> 
> This binding follows the model of msm, imx, sti, and others, where
> there is a subsystem node for the whole GPU, with nodes for the
> individual HW components within it.

I think it would be useful to have the acronyms written out one time
in the document (VC4, HVS).

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151010/151bf951/attachment.sig>

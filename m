From: robh@kernel.org (Rob Herring)
Date: Wed, 15 Mar 2017 14:52:50 -0500
Subject: [Patch v2 02/11] s5p-mfc: Adding initial support for MFC v10.10
In-Reply-To: <1488532036-13044-3-git-send-email-smitha.t@samsung.com>
References: <1488532036-13044-1-git-send-email-smitha.t@samsung.com>
 <CGME20170303090436epcas1p2097d589d9c5e6f7ee634ab9917cc987e@epcas1p2.samsung.com>
 <1488532036-13044-3-git-send-email-smitha.t@samsung.com>
Message-ID: <20170315195250.kq4tywgzmvnzuy4j@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 03, 2017 at 02:37:07PM +0530, Smitha T Murthy wrote:
> Adding the support for MFC v10.10, with new register file and
> necessary hw control, decoder, encoder and structural changes.
> 
> Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: devicetree at vger.kernel.org
> ---
>  .../devicetree/bindings/media/s5p-mfc.txt          |    1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/media/platform/s5p-mfc/regs-mfc-v10.h      |   36 ++++++++++++++++
>  drivers/media/platform/s5p-mfc/s5p_mfc.c           |   30 +++++++++++++
>  drivers/media/platform/s5p-mfc/s5p_mfc_common.h    |    4 +-
>  drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c      |    4 ++
>  drivers/media/platform/s5p-mfc/s5p_mfc_dec.c       |   44 +++++++++++---------
>  drivers/media/platform/s5p-mfc/s5p_mfc_enc.c       |   21 +++++----
>  drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c    |    9 +++-
>  drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.h    |    2 +
>  9 files changed, 118 insertions(+), 33 deletions(-)
>  create mode 100644 drivers/media/platform/s5p-mfc/regs-mfc-v10.h

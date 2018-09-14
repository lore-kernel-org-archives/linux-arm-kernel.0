From: leoyang.li@nxp.com (Li Yang)
Date: Fri, 14 Sep 2018 18:26:48 -0500
Subject: [PATCH v2 03/12] soc: fsl: dpio: add frame list format support
In-Reply-To: <20180912085937.22489-4-horia.geanta@nxp.com>
References: <20180912085937.22489-1-horia.geanta@nxp.com>
 <20180912085937.22489-4-horia.geanta@nxp.com>
Message-ID: <CADRPPNQYPZGPo0y7pv3CFFJH6Kn4rL42w8YgH-d3pMrU=Q0FFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2018 at 4:02 AM Horia Geant? <horia.geanta@nxp.com> wrote:
>
> Add support for dpaa2_fd_list format, i.e. dpaa2_fl_entry structure
> and accessors.
>
> Frame list entries (FLEs) are similar, but not identical to FDs:
> + "F" (final) bit
> - FMT[b'01] is reserved
> - DD, SC, DROPP bits (covered by "FD compatibility" field in FLE case)
> - FLC[5:0] not used for stashing
>
> Signed-off-by: Horia Geant? <horia.geanta@nxp.com>

Acked-by: Li Yang <leoyang.li@nxp.com>

> ---
>  include/soc/fsl/dpaa2-fd.h | 242 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 242 insertions(+)
>

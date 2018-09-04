From: robh@kernel.org (Rob Herring)
Date: Mon, 3 Sep 2018 20:25:18 -0500
Subject: [PATCH 2/3] Documentation: dt: binding: fsl: update property
 description for RCPM
In-Reply-To: <20180831035219.31619-2-ran.wang_1@nxp.com>
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
 <20180831035219.31619-2-ran.wang_1@nxp.com>
Message-ID: <5b8e8a71.1c69fb81.d966f.1ca1@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2018 at 11:52:18AM +0800, Ran Wang wrote:
> Add property 'big-endian' and supportted IP's configuration info.
> Remove property 'fsl,#rcpm-wakeup-cell'.

"dt-bindings: soc: ..." for the subject

It is obvious reading the diff you are removing fsl,#rcpm-wakeup-cell. 
What is not obvious is why? The commit msg should answer that.

You also are mixing several things in this patch like adding ls1012 
which you don't mention. Please split.

> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
>  Documentation/devicetree/bindings/soc/fsl/rcpm.txt |   42 ++++++-------------
>  1 files changed, 13 insertions(+), 29 deletions(-)

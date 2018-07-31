From: robh@kernel.org (Rob Herring)
Date: Tue, 31 Jul 2018 14:47:44 -0600
Subject: [PATCH v2 1/7] dt-bindings: net: Fix Broadcom iProc mdio mux
 driver base address
In-Reply-To: <1532726613-6483-2-git-send-email-arun.parameswaran@broadcom.com>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532726613-6483-2-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <20180731204744.GA9993@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2018 at 02:23:27PM -0700, Arun Parameswaran wrote:
> Modify the base address of the Broadcom iProc MDIO mux driver to
> point to the start of the block's register address space.
> 
> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
> ---
>  Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

The example is just an example, but okay...

Reviewed-by: Rob Herring <robh@kernel.org>

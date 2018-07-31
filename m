From: robh@kernel.org (Rob Herring)
Date: Tue, 31 Jul 2018 14:48:28 -0600
Subject: [PATCH v2 5/7] dt-bindings: net: Add clock handle to Broadcom
 iProc mdio mux
In-Reply-To: <1532726613-6483-6-git-send-email-arun.parameswaran@broadcom.com>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532726613-6483-6-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <20180731204828.GA12431@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2018 at 02:23:31PM -0700, Arun Parameswaran wrote:
> Add clock phandle, of the core clock driving the mdio block, as an
> optional property to the Broadcom iProc mdio mux.
> 
> The clock, when specified, will be used to setup the rate adjust registers
> in the mdio to derrive the mdio's operating frequency.
> 
> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
> ---
>  Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>

From: robh@kernel.org (Rob Herring)
Date: Wed, 7 Mar 2018 13:39:19 -0600
Subject: [PATCHv2 1/7] dt-bindings, firmware: add Intel Stratix10 service
 layer binding
In-Reply-To: <1519949975-13548-2-git-send-email-richard.gong@linux.intel.com>
References: <1519949975-13548-1-git-send-email-richard.gong@linux.intel.com>
 <1519949975-13548-2-git-send-email-richard.gong@linux.intel.com>
Message-ID: <20180307193919.56ogsh32odpk6bul@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 06:19:29PM -0600, richard.gong at linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Add a device tree binding for the Intel Stratix10 service layer driver
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> Signed-off-by: Alan Tull <atull@kernel.org>
> ---
> v2: Change to put service layer driver node under the firmware node
>     Change compatible to "intel, stratix10-svc"
> ---
>  .../bindings/firmware/intel,stratix10-svc.txt      | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt

Reviewed-by: Rob Herring <robh@kernel.org>

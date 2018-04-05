From: robh@kernel.org (Rob Herring)
Date: Thu, 5 Apr 2018 08:16:53 -0500
Subject: [PATCHv3 1/7] dt-bindings, firmware: add Intel Stratix10 service
 layer binding
In-Reply-To: <1522182014-7338-2-git-send-email-richard.gong@linux.intel.com>
References: <1522182014-7338-1-git-send-email-richard.gong@linux.intel.com>
 <1522182014-7338-2-git-send-email-richard.gong@linux.intel.com>
Message-ID: <20180405131653.2rso2ta74w663pdx@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2018 at 03:20:08PM -0500, richard.gong at linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Add a device tree binding for the Intel Stratix10 service layer driver
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> Signed-off-by: Alan Tull <atull@kernel.org>
> ---
> v2: Change to put service layer driver node under the firmware node
>     Change compatible to "intel, stratix10-svc"
> v3: No change
> ---
>  .../bindings/firmware/intel,stratix10-svc.txt      | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt

Please add acks/reviewed-by's when posting new versions.

Rob

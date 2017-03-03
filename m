From: robh@kernel.org (Rob Herring)
Date: Fri, 3 Mar 2017 00:21:17 -0600
Subject: [PATCH v3 22/25] dt-bindings: power: Add Owl SPS power domains
In-Reply-To: <20170228063535.32069-23-afaerber@suse.de>
References: <20170228063535.32069-1-afaerber@suse.de>
 <20170228063535.32069-23-afaerber@suse.de>
Message-ID: <20170303062117.yt3nnkzg75nfkq7e@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2017 at 07:35:32AM +0100, Andreas F?rber wrote:
> Define power domains for all non-reserved S500 power gates.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v3: new
>  
>  .../devicetree/bindings/power/actions,owl-sps.txt     | 17 +++++++++++++++++
>  include/dt-bindings/power/s500-powergate.h            | 19 +++++++++++++++++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/actions,owl-sps.txt
>  create mode 100644 include/dt-bindings/power/s500-powergate.h

Acked-by: Rob Herring <robh@kernel.org>

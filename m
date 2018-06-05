From: robh@kernel.org (Rob Herring)
Date: Tue, 5 Jun 2018 13:55:30 -0600
Subject: [PATCH v4 2/6] Documentation: DT: Add optional 'timeout-sec'
 property for sp805
In-Reply-To: <1527530497-10392-3-git-send-email-ray.jui@broadcom.com>
References: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com>
 <1527530497-10392-3-git-send-email-ray.jui@broadcom.com>
Message-ID: <20180605195530.GA874@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2018 at 11:01:33AM -0700, Ray Jui wrote:
> Update the SP805 binding document to add optional 'timeout-sec'
> devicetree property

Note "dt-bindings: watchdog: ..." is the preferred subject prefix.

> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> ---
>  Documentation/devicetree/bindings/watchdog/arm,sp805.txt | 2 ++
>  1 file changed, 2 insertions(+)

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

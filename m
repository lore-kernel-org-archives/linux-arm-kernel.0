From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Feb 2017 17:47:20 -0600
Subject: [PATCH 2/2] ARM: dts: NSP: Add mailbox (PDC) to NSP
In-Reply-To: <1487796146-14690-3-git-send-email-steven.lin1@broadcom.com>
References: <1487796146-14690-1-git-send-email-steven.lin1@broadcom.com>
 <1487796146-14690-3-git-send-email-steven.lin1@broadcom.com>
Message-ID: <20170227234720.jaxsnxbjcbzhf7hn@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2017 at 03:42:26PM -0500, Steve Lin wrote:
> Adds mailbox / PDC to NSP device tree.  Needs new compatibility string
> to differentiate from NS2 version.
> 
> Signed-off-by: Steve Lin <steven.lin1@broadcom.com>
> ---
>  .../devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.txt          | 6 ++++--
>  arch/arm/boot/dts/bcm-nsp.dtsi                                   | 9 +++++++++
>  2 files changed, 13 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

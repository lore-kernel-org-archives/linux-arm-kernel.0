From: mathias.nyman@linux.intel.com (Mathias Nyman)
Date: Mon, 12 May 2014 20:38:04 +0300
Subject: [PATCHv5 09/20] Documentation: dt-bindings: update xhci-platform
 DT binding
In-Reply-To: <1399832288-19899-10-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399832288-19899-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1399832288-19899-10-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <537106FC.5040708@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2014 09:17 PM, Thomas Petazzoni wrote:
> From: Gregory CLEMENT <gregory.clement@free-electrons.com>
>
> This commit extends the compatible string list of the xhci-platform
> binding with the new "armada-375-xhci" and "armada-380-xhci"
> compatible strings. It is used to describe the XHCI controller which
> is available in the Armada 375 and 38x SoCs.
>
> It also indicates that an optional 'clocks' property is now supported.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>   Documentation/devicetree/bindings/usb/usb-xhci.txt | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>

Hi

Except for the sparse warning in PATCH [8/20], and if DT people are ok with this I 
think everything is in order.

otherwise, for patches 6-9:
Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>

Greg, should this entire series go directly to you, or should we pick patches
to our own trees first (patches 6-9 for me)?

-Mathias

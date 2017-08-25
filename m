From: robh@kernel.org (Rob Herring)
Date: Fri, 25 Aug 2017 17:03:57 -0500
Subject: [PATCH v4 2/3] dt-bindings: PCI: add PCIe hotplug property
In-Reply-To: <1503564548-1834-3-git-send-email-oza.oza@broadcom.com>
References: <1503564548-1834-1-git-send-email-oza.oza@broadcom.com>
 <1503564548-1834-3-git-send-email-oza.oza@broadcom.com>
Message-ID: <20170825220356.s75yxkfasnnaygfc@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2017 at 02:19:07PM +0530, Oza Pawandeep wrote:
> Host drivers have the requirement of implementing PCI hotplug
> based on the how their SOC supports PCI hotplug.
> 
> Couple of properties have been added. the one to enable
> the hotplug feature itself, and the other caters to
> the PCI hotplug implementation with the use of gpios.
> 
> Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>

I acked v2. Please add acks when posting new versions.

Rob

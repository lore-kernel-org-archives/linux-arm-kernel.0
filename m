From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Aug 2017 15:58:08 -0500
Subject: [PATCH v2 2/3] Documentation/devicetree: Add PCIe hotplug property
In-Reply-To: <1502776547-30542-3-git-send-email-oza.oza@broadcom.com>
References: <1502776547-30542-1-git-send-email-oza.oza@broadcom.com>
 <1502776547-30542-3-git-send-email-oza.oza@broadcom.com>
Message-ID: <20170817205808.arndlcvhw3ydjh4v@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 15, 2017 at 11:25:46AM +0530, Oza Pawandeep wrote:
> Host drivers have the requirement of implementing PCI hotplug
> based on the how their SOC supports PCI hotplug.
> 
> Couple of properties have been added. the one to enable
> the hotplug feature itself, and the other caters to
> the PCI hotplug implementation with the use of gpios.
> 
> Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>

Acked-by: Rob Herring <robh@kernel.org>

"dt-bindings: PCI: ..." preferred for the subject if you respin.

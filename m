From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Aug 2017 10:09:48 -0500
Subject: [PATCH v2 06/11] Docs: dt: add devicetree binding for describing
 arm64 SDEI firmware
In-Reply-To: <20170808164616.25949-7-james.morse@arm.com>
References: <20170808164616.25949-1-james.morse@arm.com>
 <20170808164616.25949-7-james.morse@arm.com>
Message-ID: <20170817150948.x4ebg54ak7pzfley@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 08, 2017 at 05:46:11PM +0100, James Morse wrote:
> The Software Delegated Exception Interface (SDEI) is an ARM standard
> for registering callbacks from the platform firmware into the OS.
> This is typically used to implement RAS notifications, or from an
> IRQ that has been promoted to a firmware-assisted NMI.
> 
> Add a new devicetree binding to describe the SDE firmware interface.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
> * Added bound IRQ description for binding,
> * Reference SMC-CC, not 'AAPCS like'
> * Move sdei node under firmware node (and the file path)
> 
>  .../devicetree/bindings/arm/firmware/sdei.txt      | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/firmware/sdei.txt

Acked-by: Rob Herring <robh@kernel.org>

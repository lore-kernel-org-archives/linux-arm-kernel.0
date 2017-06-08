From: robh@kernel.org (Rob Herring)
Date: Thu, 8 Jun 2017 09:18:04 -0500
Subject: [PATCH v2 09/11] gpio: dt-bindings: Add documentation for gpio
 controllers on Armada 7K/8K
In-Reply-To: <7b92aabfb7309eb0b138c149cc3fc61e8f64cd61.1496413293.git-series.gregory.clement@free-electrons.com>
References: <cover.8fe5f7c62a787452878ca071fa00b953e96988ef.1496413293.git-series.gregory.clement@free-electrons.com>
 <7b92aabfb7309eb0b138c149cc3fc61e8f64cd61.1496413293.git-series.gregory.clement@free-electrons.com>
Message-ID: <20170608141804.fm72esb5lpbqcp4m@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 02, 2017 at 04:23:16PM +0200, Gregory CLEMENT wrote:
> Document the device tree binding for the gpio controllers found on the
> Marvell Armada 7K and Armada 8K SoCs.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt  | 20 ++++++++++++++++++++
>  Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt | 24 +++++++++++++++++++++++-
>  Documentation/devicetree/bindings/gpio/gpio-mvebu.txt                      | 24 +++++++++++++++++-------
>  3 files changed, 60 insertions(+), 8 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

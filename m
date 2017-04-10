From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Apr 2017 10:05:53 -0500
Subject: [PATCH 1/3] dt-bindings: power: supply: New bindings for LEGO
 MINDSTORMS EV3 battery
In-Reply-To: <1491251029-23256-2-git-send-email-david@lechnology.com>
References: <1491251029-23256-1-git-send-email-david@lechnology.com>
 <1491251029-23256-2-git-send-email-david@lechnology.com>
Message-ID: <20170410150553.35pjswc7liact3pd@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 03, 2017 at 03:23:47PM -0500, David Lechner wrote:
> This add a new device tree binding for LEGO MINDSTORMS EV3 battery. The EV3
> has some built-in capability for monitoring the attached battery.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  .../bindings/power/supply/lego_ev3_battery.txt      | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/lego_ev3_battery.txt

Acked-by: Rob Herring <robh@kernel.org>

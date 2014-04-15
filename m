From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 15 Apr 2014 15:01:59 -0600
Subject: [PATCH 5/7] net: rfkill: gpio: add device tree support
In-Reply-To: <1397544101-18135-6-git-send-email-wens@csie.org>
References: <1397544101-18135-1-git-send-email-wens@csie.org>
 <1397544101-18135-6-git-send-email-wens@csie.org>
Message-ID: <534D9E47.30708@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2014 12:41 AM, Chen-Yu Tsai wrote:

> diff --git a/Documentation/devicetree/bindings/rfkill/rfkill-gpio.txt b/Documentation/devicetree/bindings/rfkill/rfkill-gpio.txt

> +Optional properties:
> +- clocks		: phandle to clock to enable/disable

Oh, and can't we use clock-names here too, with wording like:

- clocks: Must contain an entry for each entry in clock-names.
  See ../clocks/clock-bindings.txt for details.
- clock-names: May contain any of the following entries:
  - module

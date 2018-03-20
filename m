From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 20 Mar 2018 10:03:33 -0700
Subject: [PATCH v8 01/42] dt-bindings: clock: Add new bindings for TI
 Davinci PLL clocks
In-Reply-To: <1521168778-27236-2-git-send-email-david@lechnology.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <1521168778-27236-2-git-send-email-david@lechnology.com>
Message-ID: <152156541358.183971.6354552764403526569@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting David Lechner (2018-03-15 19:52:17)
> This adds a new binding for the PLL IP blocks in the mach-davinci
> family of processors. Currently, only da850 has device tree support
> but these bindings can also work for other SoCs in this family just
> by adding new compatible strings.
> 
> Note: Although these PLL controllers are very similar to the TI Keystone
> SoCs, we are not re-using those bindings. The Keystone bindings use a
> legacy one-node-per-clock binding. Furthermore, the mach-davinici SoCs
> have a slightly different PLL register layout and a number of quirks
> that can't be handled by the existing bindings, so the keystone bindings
> could not be used as-is anyway.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next

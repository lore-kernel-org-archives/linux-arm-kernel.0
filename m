From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 20 Mar 2018 10:03:57 -0700
Subject: [PATCH v8 09/42] dt-bindings: clock: New bindings for TI Davinci
 PSC
In-Reply-To: <1521168778-27236-10-git-send-email-david@lechnology.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <1521168778-27236-10-git-send-email-david@lechnology.com>
Message-ID: <152156543724.183971.9703906314447360197@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting David Lechner (2018-03-15 19:52:25)
> This adds a new binding for the Power Sleep Controller (PSC) for the
> mach-davinci family of processors.
> 
> Note: Although TI Keystone has a very similar PSC, we are not using the
> existing bindings. Keystone is using a legacy one-node-per-clock binding
> (actually two nodes if you count the separate reset binding for the same
> IP block). Also, some davinci LPSCs have quirks that aren't handled by
> the keystone bindings, so we would be adding one compatible string per
> clock with quirks instead of just a new compatible string for each
> controller.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next

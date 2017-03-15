From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 16 Mar 2017 00:02:29 +0100
Subject: [PATCH v4 11/18] dt-bindings: power: supply: add AXP20X/AXP22X
 battery DT binding
In-Reply-To: <761e35fc-932a-953c-cfad-7e967ea3d126@free-electrons.com>
References: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
 <20170315105537.22349-12-quentin.schulz@free-electrons.com>
 <20170315222852.z2qrwoexcsjt7vs6@earth>
 <761e35fc-932a-953c-cfad-7e967ea3d126@free-electrons.com>
Message-ID: <20170315230229.woqzt6dthzmpuohd@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 15, 2017 at 11:41:07PM +0100, Quentin Schulz wrote:
> Hi,
> 
> On 15/03/2017 23:28, Sebastian Reichel wrote:
> > Hi,
> > 
> > On Wed, Mar 15, 2017 at 11:55:30AM +0100, Quentin Schulz wrote:
> >> The X-Powers AXP20X and AXP22X PMICs can have a battery as power supply.
> >>
> >> This patch adds the DT binding documentation for the battery power
> >> supply which gets various data from the PMIC, such as the battery status
> >> (charging, discharging, full, dead), current max limit, current current,
> >> battery capacity (in percentage), voltage max and min limits, current
> >> voltage and battery capacity (in Ah).
> >>
> >> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> >> Acked-by: Chen-Yu Tsai <wens@csie.org>
> >> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > 
> > I suggest to do "s/battery-power-supply/battery-fuel-gauge/g"
> > 
> 
> The IP is way more than a simple fuel gauge, you have info about the
> voltage, current, you can set different things, even though you have the
> percentage of the battery returned by the PMIC.

Most chips sold under the label battery-fuel-gauges actually give
you that kind of information ;)

> Does it really make sense to rename it that way?

If everybody is fine with it I don't mind too much.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170316/f8549572/attachment.sig>

From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 08 May 2017 18:27:02 +0200
Subject: [PATCH v5 0/5] Add ARM Mali Midgard device tree bindings and gpu
 node for rk3288
In-Reply-To: <cover.1493804968.git.guillaume.tucker@collabora.com>
References: <cover.1493804968.git.guillaume.tucker@collabora.com>
Message-ID: <12996903.t3AZceNVOh@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 3. Mai 2017, 10:56:24 CEST schrieb Guillaume Tucker:
> The ARM Mali Midgard GPU kernel driver is only available
> out-of-tree and is not going to be merged in its current form.
> However, it would be useful to have its device tree bindings
> merged.  In particular, this would enable distributions to create
> working driver packages (dkms...) without having to patch the
> kernel.
> 
> The bindings for the earlier Mali Utgard GPU family have already
> been merged, so this is essentially the same scenario but for
> newer GPUs (Mali-T604 ~ Mali-T880).
> 
> This series of patches first imports the bindings from the latest
> driver release with some clean-up then adds a gpu node for the
> rk3288 SoC.  This was successfully tested on Radxa Rock2 Square,
> Firefly, Veyron Minnie and Jerry boards using Mali kernel driver
> r16p0 and r12p0 user-space binary.

The actual devicetree parts are all Rockchip-specific, so I guess I'll just
pick up the whole series, including the binding doc, after the merge
window if nobody complains before that :-)


Heiko

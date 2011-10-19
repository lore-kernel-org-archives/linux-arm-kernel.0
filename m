From: segher@kernel.crashing.org (Segher Boessenkool)
Date: Wed, 19 Oct 2011 16:31:42 +0200
Subject: [RFC] [PATCH] ARM: tegra: emc: device tree bindings
In-Reply-To: <CAOesGMj8TREZ94RFhE3Qy=eaytOuB0YKBWw6--HAERoMB9m7Qg@mail.gmail.com>
References: <1318873976-25335-1-git-send-email-olof@lixom.net>
	<74CDBE0F657A3D45AFBB94109FB122FF173CA2CBFB@HQMAIL01.nvidia.com>
	<CAOesGMh387Oghyd_TobnTOja6tU2uU5kt-86_HwQe7nFiL+svw@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173CA2CC18@HQMAIL01.nvidia.com>
	<CAOesGMghu6Bn3RrFKEUBKkUNS_K8Y0ho3Y2uFZh_LXbfT80hFw@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173CA2CCA9@HQMAIL01.nvidia.com>
	<4E9E3801.6080707@gmail.com>
	<CAOesGMj8TREZ94RFhE3Qy=eaytOuB0YKBWw6--HAERoMB9m7Qg@mail.gmail.com>
Message-ID: <A9982E57-A106-41B5-BE89-D166F3129AED@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> In cases where unit addresses can be used to separate out identical
> entries, yes. For something like this, there's no logical addressing
> of the tables so something else must be used to distinguish them.

You can always add some dummy addressing, like is also used for cpu
nodes etc.


Segher

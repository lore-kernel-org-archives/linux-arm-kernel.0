From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 21 Feb 2017 19:20:29 +0100
Subject: [PATCH v3 17/18] ARM: dts: sun8i: sina33: enable battery power
 supply subnode
In-Reply-To: <CAGb2v64SnsrckN7+cv5woHzLTWrM455xjUQFh3dKHUNhjgBB7w@mail.gmail.com>
References: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
 <20170214094112.27426-18-quentin.schulz@free-electrons.com>
 <CAGb2v64SnsrckN7+cv5woHzLTWrM455xjUQFh3dKHUNhjgBB7w@mail.gmail.com>
Message-ID: <4512847d-45b7-c51e-10df-f5f47ae01a38@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/02/2017 05:50, Chen-Yu Tsai wrote:
> On Tue, Feb 14, 2017 at 5:41 PM, Quentin Schulz
> <quentin.schulz@free-electrons.com> wrote:
>> The Sinlinx SinA33 has an AXP223 PMIC and a battery connector, thus, we
>> enable the battery power supply subnode in its Device Tree.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Battery charger enabled without any description of the associated battery...
> In this case I think the driver should use the lowest charge current to be
> safe?
> 

Seems fair.

Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

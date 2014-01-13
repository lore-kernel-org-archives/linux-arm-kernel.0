From: robdclark@gmail.com (Rob Clark)
Date: Mon, 13 Jan 2014 14:08:59 -0500
Subject: [BUILD BUG] msm: mdp4_drv_encoder.c
In-Reply-To: <20140113185943.GF15937@n2100.arm.linux.org.uk>
References: <20140113184324.GE15937@n2100.arm.linux.org.uk>
 <CAF6AEGssWPvFkKrqZwsN+WPr=Hkgs-DXZYO7Ywdu5MSeknHGaQ@mail.gmail.com>
 <20140113185943.GF15937@n2100.arm.linux.org.uk>
Message-ID: <CAF6AEGuaa3V=CK4=8taQ_MD2Kcs2XV+P_u_iOUUAG_S0UWZ2Ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 1:59 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jan 13, 2014 at 01:56:27PM -0500, Rob Clark wrote:
>>
>> dropping this #include is already in my 3.14-rc1 pull req..
>>
>> do we need this in 3.13 too?
>
> That depends how it's ending up in my build tree of Linus' tip, plus
> my tip, plus arm-soc tip.  I guess it's a result of MSM switching to
> use the multiplatform support, which is in arm-soc rather than 3.13.

Just checked with Stephen on IRC, not needed on 3.13.  The issue
should go away once 3.14-rc1 stuff is merged.

BR,
-R

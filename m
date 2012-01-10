From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 10 Jan 2012 21:05:15 +0800
Subject: [RFC PATCH v3 2/5] pinctrl: add dt binding support for pinmux
 mappings
In-Reply-To: <7FE21149F4667147B645348EC605788508AC65@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1324402840-32451-1-git-send-email-b29396@freescale.com>
 <1324402840-32451-3-git-send-email-b29396@freescale.com>
 <74CDBE0F657A3D45AFBB94109FB122FF176BE92F00@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC6057885075542@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF176CC743EF@HQMAIL01.nvidia.com>
 <CAA+hA=RBqpSmntS2h+6xMQuRvSRHenmDgrYSSzMXHtOCpU+HCQ@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F18F8@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC605788507F698@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE39E6B@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC605788508AC65@039-SN2MPN1-013.039d.mgd.msft.net>
Message-ID: <20120110130511.GA26599@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2012 at 08:21:05AM +0000, Dong Aisheng-B29396 wrote:
> Here what I wonder is that do we need to allow the platform to use a func-name
> property in their pinmux func node or pinmux group node to specify the name.

I do not see the necessity.

> If it is allowed, then it could be flexible for soc to define their names.
> If not there may be limitations on their node names since we can only get it from
> the node name.

To me, the node name is perfectly fine to be used for that purpose.

-- 
Regards,
Shawn

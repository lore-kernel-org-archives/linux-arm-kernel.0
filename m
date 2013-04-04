From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 04 Apr 2013 13:02:50 +0200
Subject: Device Passthrough latest ARMv7 tree
In-Reply-To: <2DDB038789B01B4B80B0D3F1FF7CBDC2064D2E56@lhreml509-mbb.china.huawei.com>
References: <2DDB038789B01B4B80B0D3F1FF7CBDC2064D2E19@lhreml509-mbb.china.huawei.com>
 <2DDB038789B01B4B80B0D3F1FF7CBDC2064D2E2C@lhreml509-mbb.china.huawei.com>
 <2DDB038789B01B4B80B0D3F1FF7CBDC2064D2E41@lhreml509-mbb.china.huawei.com>
 <2DDB038789B01B4B80B0D3F1FF7CBDC2064D2E56@lhreml509-mbb.china.huawei.com>
Message-ID: <d34ce246ed426f13acd0d3b556e36182@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mario,

On Thu, 4 Apr 2013 08:53:51 +0000, Mario Smarduch
<Mario.Smarduch@huawei.com> wrote:
> Hello,
>    I'm working on device passthrough, an initial patch is for host GIC.
> Separate interrupt prioritization from deactivation for guest
interrupts.
> Guest will execute as is. 
> 
> In short patch would affect GIC mainline kernel.
> Against what repo can I submit patches given it's for virt,
> but impacts mainline?

Please use the current mainline. 3.9 contains the KVM/ARM code, and should
be used for any new development.

Plus, given that the GIC has been moved to a common location to
accommodate for arm64, this will save you some hassle later on.

Cheers,

        M.
-- 
Fast, cheap, reliable. Pick two.

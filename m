From: david.vrabel@citrix.com (David Vrabel)
Date: Fri, 11 May 2012 15:43:45 +0100
Subject: [PATCH v2] ARM: DT: Add binding for GIC virtualization extentions
 (VGIC)
In-Reply-To: <4FAD255A.4080504@arm.com>
References: <1336586277-28454-1-git-send-email-marc.zyngier@arm.com>
 <4FAD1EDE.8010505@citrix.com> <4FAD255A.4080504@arm.com>
Message-ID: <4FAD25A1.2080106@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/12 15:42, Marc Zyngier wrote:
> On 11/05/12 15:14, David Vrabel wrote:
>> On 09/05/12 18:57, Marc Zyngier wrote:
>>> The GICv2 can have virtualization extension support, consisting
>>> of an additional set of registers and interrupts. Add the necessary
>>> binding to the GIC DT documentation.
>>
>> This looks fine for Xen.
> 
> Thanks David. Can I add your Acked-by:?

Sure.

Acked-by: David Vrabel <david.vrabel@citrix.com>

David

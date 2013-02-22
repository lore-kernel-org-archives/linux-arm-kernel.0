From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Feb 2013 20:30:56 +0100
Subject: [PULL] VGIC fixes for KVM/ARM
In-Reply-To: <20130222191825.GE17833@n2100.arm.linux.org.uk>
References: <b06d478e1008aa14c12fa1ea9f8da941@localhost>
 <20130222154136.GD17833@n2100.arm.linux.org.uk>
 <215351192187808fc309b8f9c0541b1c@localhost>
 <20130222191825.GE17833@n2100.arm.linux.org.uk>
Message-ID: <6db01359033b27c77b5c65f781b458d8@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Feb 2013 19:18:25 +0000, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Feb 22, 2013 at 06:28:41PM +0100, Marc Zyngier wrote:
>> On Fri, 22 Feb 2013 15:41:36 +0000, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Fri, Feb 22, 2013 at 02:58:12PM +0100, Marc Zyngier wrote:
>> >> Arnd, Olof,
>> >> 
>> >> Please find below a pull request for a couple of fixes concerning
>> >> the VGIC implementation in KVM. No real hurry, these can probably
>> >> be applied after the merge window.
>> >> 
>> >> The branch is on top of mainline as of this morning, but I'm happy
>> >> to rebase it on something else if that's more convenient.
>> > 
>> > Now, why is this being thrown at arm-soc?  Is it not core ARM stuff,
>> > or is KVM being counted as yet another platform?
>> 
>> You're right. Arm-soc took care of the initial merge of the VGIC code
>> because of other dependencies, but now that it has been merged, I
should
>> have sent the pull request to you. Sincere apologies.
>> 
>> Shall I send you another pull request, or would you prefer these
patches
>> in the patch system?
> 
> Does it need another pull request or is your original sufficient for me
> to pull?

It is directly based on mainline as of this morning, so it should be good
for you to pull it.

Thanks,

        M.
-- 
Fast, cheap, reliable. Pick two.

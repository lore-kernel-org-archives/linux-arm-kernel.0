From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 22 Nov 2011 11:47:49 +0000
Subject: [GIT PULL] ARM irqchip consolidation
In-Reply-To: <20111121220029.GT9581@n2100.arm.linux.org.uk>
References: <4EC39D44.8000706@arm.com>
 <20111117172319.GX9581@n2100.arm.linux.org.uk> <4EC54DBB.9090309@arm.com>
 <20111121220029.GT9581@n2100.arm.linux.org.uk>
Message-ID: <4ECB8BE5.7050003@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 21/11/11 22:00, Russell King - ARM Linux wrote:
> On Thu, Nov 17, 2011 at 06:08:59PM +0000, Marc Zyngier wrote:
>> If you have a stable branch on which I can rebase, I'm happy to do it
>> (I've just resolved these conflicts on -next). If it's more convenient
>> to do it later in the cycle, I can wait. Just let me know what is the
>> most convenient route for you.
> 
> I've now merged the restart changes into the 'devel' branch, and then
> followed on with your changes on top of that - fixing the conflicts
> along the way.
> 
> I decided not to push it out in the devel-stable branch until you've
> had a chance to verify that the conflict resolution is correct - I've
> added some limited explanations in the merge commit for the two things
> which weren't a trivial resolution.  Once you've confirmed it's fine,
> I'll push the stuff over to the devel-stable branch.

I had a quick look at linux-next, and the conflict resolution seem
perfectly sound.

Thanks a lot for going through this, very much appreciated.

	M.
-- 
Jazz is not dead. It just smells funny...

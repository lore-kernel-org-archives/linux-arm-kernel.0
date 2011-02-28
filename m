From: dv@vollmann.ch (Detlef Vollmann)
Date: Mon, 28 Feb 2011 17:29:07 +0100
Subject: When does mach-types get updated in a tree?
In-Reply-To: <20110228154913.GC1937@n2100.arm.linux.org.uk>
References: <a9937fcf-a4cb-41c5-a767-ecfebae5c748@VA3EHSMHS024.ehs.local>	<20110228101030.GB29843@n2100.arm.linux.org.uk>	<0812376c-ea4b-4185-aa6e-6fb582dce21f@VA3EHSMHS032.ehs.local>	<20110228151100.GB1937@n2100.arm.linux.org.uk>	<d2617607-dfa2-4f72-9a42-4345b4a43307@VA3EHSMHS027.ehs.local>
	<20110228154913.GC1937@n2100.arm.linux.org.uk>
Message-ID: <4D6BCD53.5070106@vollmann.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/11 16:49, Russell King - ARM Linux wrote:
>>> I do think we're heading for a major problem with the mach-types file
>>> becoming too big inspite of its brevity.  I think I may start marking
>>> entries as 'inactive' and therefore omitted from the kernel's tree if
>>> they don't appear in mainline within one year of being allocated (or
>>> some similar rule.)

> Having now done some investigations, this is silly.  About 86% of the
> entries in the machine registry are not merged into the kernel.  48%
> of the contents of the machine registry refer to platforms registered
> more than two years ago but are not merged into mainline.  For four
> years, that figure drops to 27%.  For one year, it's 64%.
>
> So, merely implmenting a rule which says that entries which haven't
> been merged into mainline within 12 months from the date they were last
> updated would cut the file down to about 48K, almost 90K smaller.  I
> think that's worth doing.
Hmmm, we have currently two entries registered for CPU modules we
use in a number of internal projects.  Though we're happy to
share the code for these modules, we never intended to propose it
for mainline (as nobody alse can use these modules).
What do you propose for such cases?
Do you have a block of numbers for "private use"?

   Detlef

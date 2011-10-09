From: tom.leiming@gmail.com (Ming Lei)
Date: Sun, 9 Oct 2011 19:35:50 +0800
Subject: [GIT PULL] I2C: OMAP: misc. cleanup for v3.2
In-Reply-To: <87aa9f771n.fsf@ti.com>
References: <871uwbhdoj.fsf@ti.com> <4E669F36.2070008@ti.com>
	<4E80FD1A.5040006@deeprootsystems.com>
	<20111004210832.GC13323@freya.fluff.org> <87aa9f771n.fsf@ti.com>
Message-ID: <CACVXFVP85gS=FdWcecGZYWSN+U5q0Z9h9zURNmFOiM2sWOPmNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 6, 2011 at 12:11 AM, Kevin Hilman <khilman@ti.com> wrote:
> Ben Dooks <ben-i2c@fluff.org> writes:
>
>> On Mon, Sep 26, 2011 at 03:30:50PM -0700, Kevin Hilman wrote:
>>> ping
>>>
>>> On 09/06/2011 03:31 PM, Kevin Hilman wrote:
>>> >Hi Ben,
>>> >
>>> >On 08/23/2011 05:10 PM, Kevin Hilman wrote:
>>> >>Ben,
>>> >>
>>> >>Here's one more I2C cleanup series for v3.2.
>>> >>
>>> >>It applies on top of my for_3.2/i2c-fixes branch just submitted.
>>> >>
>>> >>Please pull into your tree for linux-next.
>>> >
>>> >I see you pulled the other two, can you pull this one as well?
>>
>> I've tried, but it seems to note that everything is up to date.
>>
>> Is this a suitable branch to pull onto latest so I can reset
>> my next tree?
>
> Yes.
>
> The i2c-cleanup branch[1] is based on top of the previous two (i2c-andy
> and i2c-fixes) so if you reset your next-i2c branch and just pull
> i2c-cleanup, you'll get all three.

BTW:

The patch[1] is a fix patch, which fix the OOPS[2] during system resume, so
should CC -stable tree.

[1], I2C: OMAP: remove dev->idle, use usage counting provided by runtime PM
[2], http://marc.info/?l=linux-omap&m=131658936429671&w=2

thanks,
-- 
Ming Lei

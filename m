From: khilman@ti.com (Kevin Hilman)
Date: Wed, 05 Oct 2011 09:11:00 -0700
Subject: [GIT PULL] I2C: OMAP: misc. cleanup for v3.2
In-Reply-To: <20111004210832.GC13323@freya.fluff.org> (Ben Dooks's message of
	"Tue, 4 Oct 2011 22:08:32 +0100")
References: <871uwbhdoj.fsf@ti.com> <4E669F36.2070008@ti.com>
	<4E80FD1A.5040006@deeprootsystems.com>
	<20111004210832.GC13323@freya.fluff.org>
Message-ID: <87aa9f771n.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Dooks <ben-i2c@fluff.org> writes:

> On Mon, Sep 26, 2011 at 03:30:50PM -0700, Kevin Hilman wrote:
>> ping
>> 
>> On 09/06/2011 03:31 PM, Kevin Hilman wrote:
>> >Hi Ben,
>> >
>> >On 08/23/2011 05:10 PM, Kevin Hilman wrote:
>> >>Ben,
>> >>
>> >>Here's one more I2C cleanup series for v3.2.
>> >>
>> >>It applies on top of my for_3.2/i2c-fixes branch just submitted.
>> >>
>> >>Please pull into your tree for linux-next.
>> >
>> >I see you pulled the other two, can you pull this one as well?
>
> I've tried, but it seems to note that everything is up to date.
>
> Is this a suitable branch to pull onto latest so I can reset
> my next tree?

Yes.

The i2c-cleanup branch[1] is based on top of the previous two (i2c-andy
and i2c-fixes) so if you reset your next-i2c branch and just pull
i2c-cleanup, you'll get all three.

Kevin

[1] git://github.com/khilman/linux-omap-pm.git for_3.2/i2c-cleanup

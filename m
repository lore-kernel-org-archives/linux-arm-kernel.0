From: nm@ti.com (Nishanth Menon)
Date: Fri, 17 Dec 2010 17:22:03 -0600
Subject: [PATCH 0/7 v5] OMAP3: clean up ASM sleep code
In-Reply-To: <AANLkTi=4XhE+fYDa9BYqk+1yb08Kiu3ppYNqEfW2w5Hf@mail.gmail.com>
References: <1292580506-4421-1-git-send-email-j-pihet@ti.com>	<87bp4k6m1d.fsf@deeprootsystems.com>
	<AANLkTi=4XhE+fYDa9BYqk+1yb08Kiu3ppYNqEfW2w5Hf@mail.gmail.com>
Message-ID: <4D0BF09B.5050709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean Pihet had written, on 12/17/2010 05:07 PM, the following:
> Hi Kevin,
> 
> On Sat, Dec 18, 2010 at 12:02 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Hi Jean,
>>
>> jean.pihet at newoldbits.com writes:
>>
>>> From: Jean Pihet <j-pihet@ti.com>
>>>
>>> This patch only contains clean-ups and cosmetic changes,
>>> no functional change.
>>>
>>> Clean-up of the ASM sleep code, for better readability and
>>> easier maintenance.
>>>
>>> Applies on top of Nishant's latest idle path errata fixes step 2,
>>> cf. http://marc.info/?l=linux-omap&m=129139584919242&w=2
>> Can you do one more spin of this series in order to collect the
>> reviewed-by/tested-by tags posted, and address some of Nishanth's
>> comments.  Since we are reaching a merge window deadline, I'll leave it
>> to your discretion to decide which of Nishanth's suggestions to address
>> now and which to address later.
> Sure I will post a new version tomorrow.
> This will include some fixes after Nishant's comments. The rest can be
> done later after we agree on the future changes.
Sounds good to me as well.. the minor cleanups should be easy to do..
will help with testing tomorrow on the new series if there are any 
functional changes. I will post out my revamped series as well 2morrow.


-- 
Regards,
Nishanth Menon

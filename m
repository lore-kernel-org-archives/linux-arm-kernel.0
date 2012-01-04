From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 4 Jan 2012 14:56:17 -0700
Subject: [PATCH v2 02/10] i2c: OMAP: Add DT support for i2c controller
In-Reply-To: <87obujb1j2.fsf@ti.com>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
 <1323439361-1647-3-git-send-email-b-cousson@ti.com> <87hb14q7vj.fsf@ti.com>
 <4F0455D8.7060904@ti.com> <87obujb1j2.fsf@ti.com>
Message-ID: <CACxGe6stVjLxpDrRpimqefPsyeGRAz3Gd1=myVvfzdupn7kvtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 4, 2012 at 2:28 PM, Kevin Hilman <khilman@ti.com> wrote:
> "Cousson, Benoit" <b-cousson@ti.com> writes:
>
>> Hi Kevin,
>>
>> On 12/14/2011 2:06 AM, Kevin Hilman wrote:
>>> Benoit Cousson<b-cousson@ti.com> ?writes:
>>>
>>>> Add initial DT support to retrieve the frequency using a
>>>> DT attribute instead of the pdata pointer if of_node exist.
>>>>
>>>> Add documentation for omap i2c controller binding.
>>>>
>>>> Based on original patches from Manju and Grant.
>>>>
>>>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>>>> Cc: Ben Dooks<ben-linux@fluff.org>
>>>
>>> This seems indepenent from the rest of the series, and I can queue up
>>> for merge via the I2C tree.
>>>
>>> Benoit, please confirm that we shouldn't have any problems if this patch
>>> goes independently.
>>>
>>> Grant/Rob, with your ack on the bindings, I can queue this up for the
>>> I2C maintainers along with some other OMAP I2C changes for v3.3.
>>
>> I removed the nasty bindings and got the Reviewed-by: from Rob for the
>> v4 [1].
>>
>> Could you take it in your branch? I've just tried merging your
>> for_3.3/i2c/misc on top of my for_3.3/3_omap_dt_i2c_twl branch and
>> tested it successfully on OMAP4 DT boot.
>
> Yes, I'll add v4 to my i2c/misc branch and add Grant's ack and queue.
>
> Note that Ben Dooks has not responded to any of my queries or pull
> requests, either for v3.2 fixes or for the v3.3 merge window, so
> unfortunately it doesn't look like this will make it for v3.3 unless Ben
> starts responding. ?:(
>
> Kevin

Get it into linux-next anyway.  If Ben doesn't respond, then you can
ask Linus to pull directly near the end of the merge window.  I don't
see any benefit in making this sit out for another cycle.

g.



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

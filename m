From: shweta.gulati@ti.com (Gulati, Shweta)
Date: Thu, 12 May 2011 18:18:24 +0530
Subject: [PATCH V3] OMAP3+: SR Layer Cleanup
In-Reply-To: <87fwokcknl.fsf@ti.com>
References: <1305105166-26109-1-git-send-email-shweta.gulati@ti.com>
	<BANLkTimem2qc8_8pHOHMiW_hAeUdtg3PBw@mail.gmail.com>
	<87fwokcknl.fsf@ti.com>
Message-ID: <BANLkTiny22x5ov3fJSLW6bc9bxz1xH1Xdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

On Thu, May 12, 2011 at 3:20 PM, Kevin Hilman <khilman@ti.com> wrote:
> "Menon, Nishanth" <nm@ti.com> writes:
>
>> On Wed, May 11, 2011 at 04:12, Shweta Gulati <shweta.gulati@ti.com> wrote:
>>> To set sr ntarget values ?for all volt_domain,
>>> volt_table is retrieved by doing a look_up of 'vdd_name'
>>> field from omap_hwmod but voltage domain pointer does not
>>> belong to omap_hwmod and is not used anywhere else.
>>> As a part of voltage layer and SR Layer clean up volt
>>> pointer is removed from omap_hwmod and added in dev
>>> attributes of SR.
>>>
>>> Tested on OMAP3630 SDP and OMAP4430 SDP Board
>>>
>>> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
>>> Cc: Nishanth Menon <nm@ti.com>
>>> ---
>>> V3:
>>> ? Changed the Subject and Rephrased Commit log as reviewed
>>> ? by Nishanth Menon.
>>> ?V2:
>>> ? Rebased on latest 'pm-wip/voltdm_a' branch.
>> thanks.. actually it applies on voltdm_c branch as well :)
>
> Can this be taken as an Ack? ?if so, Shweta please add an Acked-by from
> Nishanth in your updated patch. ?Thanks.
>
>> might be
>> good if kevin where to roll it up
>
> Yes, I'll pick this one up (after Todd's comments are addressed.)
I would address all the comments and post updated version soon, thanks.
> Kevin
>
>



-- 
Thanks,
Regards,
Shweta

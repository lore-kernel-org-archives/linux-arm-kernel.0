From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 02 Aug 2014 15:09:30 +0200
Subject: [PATCH v6 04/10] ARM: dts: Clean up exynos5250-snow
In-Reply-To: <53DCE2BA.7010803@suse.de>
References: <1406940750-15880-1-git-send-email-afaerber@suse.de>
 <1406940750-15880-5-git-send-email-afaerber@suse.de>
 <53DCD7D7.2070208@gmail.com> <53DCDFF3.7030909@gmail.com>
 <53DCE2BA.7010803@suse.de>
Message-ID: <53DCE30A.7020201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02.08.2014 15:08, Andreas F?rber wrote:
> Am 02.08.2014 14:56, schrieb Tomasz Figa:
>> On 02.08.2014 14:21, Tomasz Figa wrote:
>>> On 02.08.2014 02:52, Andreas F?rber wrote:
>>>> Use the new style of referencing inherited nodes and use symbolic names.
>>>> Reorder one pinctrl node in GPIO order.
>>>>
>>>> Goal is the alignment of all exynos5250 based device trees for comparison.
>>>>
>>>> Suggested-by: Doug Anderson <dianders@chromium.org>
>>>> Reviewed-by: Doug Anderson <dianders@chromium.org>
>>>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>>>> ---
>>>>  v5 -> v6:
>>>>  * Split off label additions (Doug Anderson)
>>>>  * Fixed alphabetical order of sd3_* nodes (Doug Anderson)
>>>>  
>>>>  v4 -> v5:
>>>>  * Introduced labels to consistently use new referencing style (Tomasz Figa)
>>>>  * Use IRQ_TYPE_* constants
>>>>  * Use some more GPIO_ACTIVE_*
>>>>
>>>>  v3 -> v4: Unchanged
>>>>  
>>>>  v3: New (Doug Anderson)
>>>>
>>>>  arch/arm/boot/dts/exynos5250-snow.dts | 291 +++++++++++++++++-----------------
>>>>  1 file changed, 145 insertions(+), 146 deletions(-)
>>>
>>> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
>>
>> Just for convenience of other reviewers, here are actual changes done do
>> the device tree after compiling into dtb and then back into dts:
> 
> Erm, to not confuse reviewers, this must be over the whole series:

Erm, right, I have forgot to state this, sorry. Similarly for other dtb
diffs.

Best regards,
Tomasz

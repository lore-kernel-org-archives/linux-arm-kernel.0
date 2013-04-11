From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Thu, 11 Apr 2013 14:57:17 -0400
Subject: [v2,01/14] thermal: Rename driver 'kirkwood' -> 'mvebu'
In-Reply-To: <5167053F.70709@ti.com>
References: <1363991114-4225-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <5166DE30.3020001@ti.com> <20130411163156.GB2279@localhost>
 <5167053F.70709@ti.com>
Message-ID: <5167078D.7010807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-04-2013 14:47, Eduardo Valentin wrote:
> On 11-04-2013 12:31, Ezequiel Garcia wrote:
>> Hi Eduardo,
>>
>> Thanks for your testing.
>>
>> On Thu, Apr 11, 2013 at 12:00:48PM -0400, Eduardo Valentin wrote:
>>> Hello Ezequiel,
>>>
>>> Two minor comments.
>>>
>>> On 22-03-2013 18:25, Ezequiel Garcia wrote:
>>>> This driver will support several Marvell SoC, so it is convenient
>>>> to rename it to 'mvebu' to represent accurately the hardware it
>>>> supports.
>>>>
>>>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>>>>
>>>> ---
>>>> .../bindings/thermal/kirkwood-thermal.txt          |   15 ---
>>>>    .../devicetree/bindings/thermal/mvebu-thermal.txt  |   15 +++
>>>>    drivers/thermal/Kconfig                            |   10 +-
>>>>    drivers/thermal/Makefile                           |    2 +-
>>>>    drivers/thermal/kirkwood_thermal.c                 |  134
>>>> --------------------
>>>>    drivers/thermal/mvebu_thermal.c                    |  134
>>>> ++++++++++++++++++++
>>>>    6 files changed, 155 insertions(+), 155 deletions(-)
>>>>    delete mode 100644
>>>> Documentation/devicetree/bindings/thermal/kirkwood-thermal.txt
>>>>    create mode 100644
>>>> Documentation/devicetree/bindings/thermal/mvebu-thermal.txt
>>>>    delete mode 100644 drivers/thermal/kirkwood_thermal.c
>>>>    create mode 100644 drivers/thermal/mvebu_thermal.c
>>>
>>> When sending renames, use git format-patch --find-renames. The summary
>>> will be much descriptive on what you have done.
>>>
>>
>> Yes, you're right I forgot about this.
>>
>>> I tried applying this patch on top of linux-next, linus/master,
>>> ruis/thermal, on top of the your suggested dependencies, and all failed.
>>> What is your base?
>>>
>>
>> Well, first of all this patchset has been dropped entirely after some
>> discussion.
>> If you're interested in this discussion you can read:
>>
>>    http://www.spinics.net/lists/arm-kernel/msg231697.html
>>
>> If you still want to try this series, the easiest way is to try
>>
>>
>> https://github.com/MISL-EBU-System-SW/mainline-public/commits/mvebu-thermal-v2
>>
>>
>> That branch is based on v3.9-rc2, with a bunch of patches applied as
>> explained in the cover letter.
>>
>> I appreciate your feedback a lot, but this are really ancient patches!
>> You came in a little late :)
>
>
> OK. Thanks for updating me. On the other hand. Some of your patches are
> still applicable. Can you please resend them based on kirkwood file still?
>

Specifically, patches 04/05/06 are still applicable to the kirkwood 
driver. Feel free to resend them with my Acked-by.

>>
>
>
>

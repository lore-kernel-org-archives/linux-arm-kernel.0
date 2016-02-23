From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 23 Feb 2016 23:11:22 +0100
Subject: [linux-sunxi] [PATCH v2] ARM: dts: sun7i: Add dts file for the
 lamobo-r1 board
In-Reply-To: <20160223221041.GA2992@excalibur.cnev.de>
References: <1456260090-23635-1-git-send-email-hdegoede@redhat.com>
 <20160223221041.GA2992@excalibur.cnev.de>
Message-ID: <56CCD90A.5070908@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/23/2016 11:10 PM, Karsten Merker wrote:
> On Tue, Feb 23, 2016 at 09:41:30PM +0100, Hans de Goede wrote:
>> From: Jelle de Jong <jelledejong@powercraft.nl>
>>
>> The lamobo-r1 board, sometimes called the BPI-R1 but not labelled as such
>> on the PCB, is meant as a A20 based router board. As such the board comes
>> with a built-in switch chip giving it 5 gigabit ethernet boards, and it
>
> s/gigabit ethernet boards/gigabit ethernet ports/ ?

Erm, yes.

Regards,

hans


>
>> has a large empty area on the pcb with mounting holes which will fit a
>> 2.5 inch harddisk. To complete its networking features it has a
>> Realtek RTL8192CU for WiFi 802.11 b/g/n.
>>
>> Signed-off-by: Jelle de Jong <jelledejong@powercraft.nl>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Regards,
> Karsten
>

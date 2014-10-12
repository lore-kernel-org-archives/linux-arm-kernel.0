From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 12 Oct 2014 23:32:06 +0800
Subject: [linux-sunxi] [PATCH 0/5] clk: sunxi: Add peripheral bus clock
 support for A80
In-Reply-To: <543A5BCD.5090806@redhat.com>
References: <1413106825-5777-1-git-send-email-wens@csie.org>
 <543A5BCD.5090806@redhat.com>
Message-ID: <CAGb2v640m71bukRzhX9BiOq42x=roWjZ8-gFCZV2ctS+5AsrXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Sun, Oct 12, 2014 at 6:45 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi ChenYu,
>
> On 10/12/2014 11:40 AM, Chen-Yu Tsai wrote:
>> Hi everyone,
>>
>> This series adds support for the basic bus (AHB/APB) clocks used by
>> peripherals on the A80 SoC. This series is based on my previous A80
>> bringup series.
>
> Cool stuff, any chance you could write a quick howto for getting an
> upstream kernel to run on the Merrii A80 optimus board, for lazy / very
> busy people like me? Preferably including a link to an sdcard image
> which already has all the bootloader bits in place ?

I keep a short status report and howto on my user page on the linux-sunxi wiki:

    http://linux-sunxi.org/User:Wens#A80_Optimus

I will try to expand it this week. Feel free to let me know if something is
fuzzy or doesn't make sense.


ChenYu

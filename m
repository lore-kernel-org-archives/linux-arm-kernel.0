From: chris.brand@broadcom.com (Chris Brand)
Date: Fri, 6 May 2016 10:49:00 -0700
Subject: [PATCH 6/6] arm: dt: bcm23550: Add device tree files
In-Reply-To: <9191808.kbIrFQuH7z@wuerfel>
References: <1462481334-8943-1-git-send-email-chris.brand@broadcom.com>
 <1462481334-8943-7-git-send-email-chris.brand@broadcom.com>
 <9191808.kbIrFQuH7z@wuerfel>
Message-ID: <CAMsMSK9usB6+tfrUFwhBW+WUc1rW3eNmWG-SCy5RF7JydsWRZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 5, 2016 at 2:05 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 05 May 2016 13:48:54 Chris Brand wrote:
>> +
>> +       chosen {
>> +               bootargs = "console=ttyS0,115200n8";
>> +       };
>> +
>>
>
> Can you move this into the .dts file, and add a stdout-path
> property to make earlycon work?
>
>         Arnd

Will do. Thanks, Arnd.

Chris

From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 12 Dec 2013 16:50:20 +0100
Subject: [PATCH 3/3] pinctrl: at91: implement at91_pinconf_dbg_show
In-Reply-To: <CACRpkdbAmPxVdQ_hVQSQpgVu324Jg9D6FYj-OyfsorPP2zzdLw@mail.gmail.com>
References: <1386421734-10240-1-git-send-email-alexandre.belloni@free-electrons.com>	<1386421734-10240-3-git-send-email-alexandre.belloni@free-electrons.com>
 <CACRpkdbAmPxVdQ_hVQSQpgVu324Jg9D6FYj-OyfsorPP2zzdLw@mail.gmail.com>
Message-ID: <52A9DB3C.7070107@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2013 15:45, Linus Walleij wrote:
> On Sat, Dec 7, 2013 at 2:08 PM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
>
>> This allows to get the pin configuration by using debugfs. On my system:
>>  # cat /sys/kernel/debug/pinctrl/pinctrl.3/pinconf-pins
>>
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> This is a more invasive patch so I prefer if Laurent ACK this before
> I apply it.

Hum, just to be clear, this is an Atmel chip and the Atmel maintainers
were already in copy. I believe Laurent already has a lot on his plate
with CDF ;)


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

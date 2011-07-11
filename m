From: bryan.wu@canonical.com (Bryan Wu)
Date: Mon, 11 Jul 2011 22:07:46 +0800
Subject: [PATCH 05/17] mach-ks8695: remove leds driver, since nobody use it
In-Reply-To: <alpine.LFD.2.00.1107110956280.14596@xanadu.home>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
	<1309955687-19365-6-git-send-email-bryan.wu@canonical.com>
	<CAFumwP1abk+-R-mht9BmKhU9opfVNUjD1PTBha--O6Ts5SCuQg@mail.gmail.com>
	<4E1ADA59.40409@ru.mvista.com>
	<CAK5ve-JujN6t5PanWdc89Wgn-6G+K214TkUxoUq1NkS8v6eMEw@mail.gmail.com>
	<alpine.LFD.2.00.1107110956280.14596@xanadu.home>
Message-ID: <CAK5ve-+eFT6SGQTrKfQOoqqOYBe19r4EjtJnVrfuU92au4A5zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 10:00 PM, Nicolas Pitre
<nicolas.pitre@linaro.org> wrote:
> On Mon, 11 Jul 2011, Bryan Wu wrote:
>
>> On Mon, Jul 11, 2011 at 7:11 PM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
>> > Hello.
>> >
>> > On 09-07-2011 0:23, Andrew Victor wrote:
>> >
>> >>> Signed-off-by: Bryan Wu<bryan.wu@canonical.com>
>> >
>> >> As the original author of this code.
>> >
>> >> Acked-by: Andrew Victor <linux@maxim.org.za>
>> >
>> > ? If you're the original author, shouldn't there be:
>> >
>> > From: Andrew Victor <linux@maxim.org.za>
>> >
>>
>> No problem, I will change that.
>
> Beware. ?Is Andrew Victor the original author of the code being removed
> here and in this case he's indicating his agreement to the removal of
> his code, or he is the one actually responsible for the removal? ?If the
> former then it is wrong to put a "From" with his name and the
> "Acked-by:" is the right thing to do.
>

Right, I was confused by the email. I prepared the removing patch and
Andrew said "Acked-by".
Andrew, is that what you want?

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com

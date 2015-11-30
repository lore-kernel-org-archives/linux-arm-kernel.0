From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 30 Nov 2015 17:40:05 +0100
Subject: [PATCH net-next 3/3] net: mvneta: Add naive RSS support
In-Reply-To: <CAPv3WKfEJGAHgDvfyeHKZaiJqbsyrV+uKM+E3enbNLVznLY6zA@mail.gmail.com>
 (Marcin Wojtas's message of "Sat, 28 Nov 2015 17:43:57 +0100")
References: <1448463243-21057-1-git-send-email-gregory.clement@free-electrons.com>
 <1448463243-21057-4-git-send-email-gregory.clement@free-electrons.com>
 <CAPv3WKfEJGAHgDvfyeHKZaiJqbsyrV+uKM+E3enbNLVznLY6zA@mail.gmail.com>
Message-ID: <87poyr4f16.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcin,
 
 On sam., nov. 28 2015, Marcin Wojtas <mw@semihalf.com> wrote:

> Hi Gregory,
>
>> +
>> +       /* update unicast mapping */
>> +       mvneta_set_rx_mode(pp->dev);
>
> I know it may be an ultimate level of nitpicking, but can you start a
> comment with capital letter?:)

If I got other review, then I can fix it in the next version. But if you
have a look on the otehr commet not all of them start by capital letter.

Thanks,

Greogry

>
> Best regards,
> Marcin

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

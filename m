From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 17 Jun 2013 13:05:47 +0900
Subject: [PATCH 14/15] ARM: shmobile: Remove AP4EVB board support
In-Reply-To: <201306141629.26580.arnd@arndb.de>
References: <1371106793-25071-1-git-send-email-horms+renesas@verge.net.au>
 <Pine.LNX.4.64.1306132128370.3777@axis700.grange>
 <CANqRtoSx4Jf_EfG3LvkpoOED4-SuOdWjRedz-RbwGCOcOeP-Xg@mail.gmail.com>
 <201306141629.26580.arnd@arndb.de>
Message-ID: <CANqRtoQVqfZaGbuVLiY8PiMTjVpt8VDs7KZyqnqjud+1yZtvQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Jun 14, 2013 at 11:29 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 14 June 2013, Magnus Damm wrote:
>> > If still possible, would be good to delay removing this board until we
>> > complete our discussion.
>>
>> If fine with keeping the board if someone can show me progress in the
>> area of INTC DT support. Recently I have not seen anything.
>
> As mentioned the last time we discussed this, I'm fine with using the
> existing code and "legacy" irqdomain for the older INTC implementations,
> as long as all the new ones can use your new generic code.

Thanks for explaining once again. Do you have any issues with us
reducing the number of supported boards and/or SoCs?

/ magnus

From: kaloz@openwrt.org (Imre Kaloz)
Date: Mon, 23 Feb 2015 19:43:55 +0100
Subject: [PATCHv3] mvebu: add Linksys WRT1900AC (Mamba) support
In-Reply-To: <54EB7255.7090806@free-electrons.com>
References: <1424089864-15651-1-git-send-email-kaloz@openwrt.org>
 <54EB7255.7090806@free-electrons.com>
Message-ID: <op.xuiwzhcu2s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Mon, 23 Feb 2015 19:32:53 +0100, Gregory CLEMENT  
<gregory.clement@free-electrons.com> wrote:

...

>> @@ -0,0 +1,348 @@
>> +/*
>> + * Device Tree file for the Linksys WRT1900AC (Mamba).
>> + *
>> + * Note: this board is shipped with a new generation boot loader that
>> + * remaps internal registers at 0xf1000000. Therefore, if earlyprintk
>> + * is used, the CONFIG_DEBUG_MVEBU_UART_ALTERNATE option should be
>
> This symbol name has been removed and DEBUG_MVEBU_UART0_ALTERNATE would
> be used instead.
>
> Besides this,
>
> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>
> You don't have to resend a new version for this, I can amend
> your patch while applying it. So unless there is new comments
> I will add your patch to the mvebu tree in a couple of days.

I knew I will forget something - this has been noted by Andrew back then  
:) Thank you for taking care of this.


Best,

Imre

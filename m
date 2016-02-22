From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 22 Feb 2016 21:33:38 +0900
Subject: [PATCH 0/6] ARM: decompressor: several cleanups
In-Reply-To: <20160222121805.GD19428@n2100.arm.linux.org.uk>
References: <1456126277-14633-1-git-send-email-yamada.masahiro@socionext.com>
 <20160222113625.GC19428@n2100.arm.linux.org.uk>
 <CAK7LNAQEwm=2bHX+kTxFVJTh-sFX+3MBgwuEmmNM-XoyvdbWRA@mail.gmail.com>
 <20160222121805.GD19428@n2100.arm.linux.org.uk>
Message-ID: <CAK7LNAS0UVWezhH+KCrvUFeWvJkDzyDEV=-Ng5e9f2G1jJDwWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

2016-02-22 21:18 GMT+09:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Mon, Feb 22, 2016 at 09:08:05PM +0900, Masahiro Yamada wrote:
>> I did build-test, changing the configuration
>> CONFIG_KERNEL_GZIP -> CONFIG_KERNEL_LZMA -> CONFIG_KERNEL_XZ -> ...
>>
>> I confirmed zImage was created from the expected piggy.
>>
>> For run-test, it worked fine too.
>
> Okay, please drop them into the patch system, thanks.

I did so.  Thanks.



-- 
Best Regards
Masahiro Yamada

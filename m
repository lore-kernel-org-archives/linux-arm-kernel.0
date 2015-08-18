From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 18 Aug 2015 19:54:31 +0900
Subject: [PATCH v2] ARM: add boot image dependencies to not generate
 invalid images
In-Reply-To: <20150818104458.GO7557@n2100.arm.linux.org.uk>
References: <1439049211-4181-1-git-send-email-yamada.masahiro@socionext.com>
 <20150818104458.GO7557@n2100.arm.linux.org.uk>
Message-ID: <CAK7LNAQ6kqoV_6zYA_6C-Gop8vbs66gsWDVZGrTong290Z_KWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,


2015-08-18 19:44 GMT+09:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Sun, Aug 09, 2015 at 12:53:31AM +0900, Masahiro Yamada wrote:
>> U-Boot is often used to boot the kernel on ARM boards, but uImage
>> is not built by "make all", so we are often inclined to do
>> "make all uImage" to generate DTBs, modules and uImage in a single
>> command, but we should notice a pitfall behind it.  In fact,
>> "make all uImage" could generate an invalid uImage if it is run with
>> the parallel option (-j).
>
> Please put this patch in the patch system.  Thanks.


I posted it yesterday.

ID: 8418/1



-- 
Best Regards
Masahiro Yamada

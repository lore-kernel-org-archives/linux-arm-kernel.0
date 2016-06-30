From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 30 Jun 2016 20:10:42 +0900
Subject: [Question] Memory attribute reserved by Device Tree?
Message-ID: <CAK7LNATGoP-Wn-wiK_CgD_v=rQXyt937qRvr8LkUQ06jHB7FAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Which memory attribute will ARM/ARM64 Linux
set to the memory region reserved by
/memreserve/ of Device Tree?


Normal memory non-cacheable?
Or, cacheable?
Or, not defined?

Perhaps actual behavior depends on whether the reserved area is
located in the low-memory region?


Thanks,


-- 
Best Regards
Masahiro Yamada

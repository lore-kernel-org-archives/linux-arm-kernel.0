From: ryabinin.a.a@gmail.com (Andrey Ryabinin)
Date: Wed, 12 Aug 2015 12:30:37 +0300
Subject: [PATCH v5 2/6] x86/kasan,
 mm: introduce generic kasan_populate_zero_shadow()
In-Reply-To: <20150811164010.GJ23307@e104818-lin.cambridge.arm.com>
References: <1439259499-13913-1-git-send-email-ryabinin.a.a@gmail.com>
 <1439259499-13913-3-git-send-email-ryabinin.a.a@gmail.com>
 <20150811154117.GH23307@e104818-lin.cambridge.arm.com>
 <55CA21E8.2060704@gmail.com>
 <20150811164010.GJ23307@e104818-lin.cambridge.arm.com>
Message-ID: <CAPAsAGwDNpRBLAvyCSpR9ZO9tAmHx-XYjVDZPECeQkU0WOw5jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-08-11 19:40 GMT+03:00 Catalin Marinas <catalin.marinas@arm.com>:
>
> Not sure how you plan to merge it though since there are x86
> dependencies. I could send the whole series via tip or the mm tree (and
> I guess it's pretty late for 4.3).

Via mm tree, I guess.
If this is too late for 4.3, then I'll update changelog and send v6
after 4.3-rc1 release.

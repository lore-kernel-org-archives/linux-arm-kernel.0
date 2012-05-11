From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 11 May 2012 19:37:56 +0900
Subject: [PATCHv2 0/3] Add support for DRM display subsystem
In-Reply-To: <CAH9JG2U83+q9NKuvZV4s_iHvDTrQ-RCEqx=9L9uwqiMhYMSiHA@mail.gmail.com>
References: <1331635180-7207-1-git-send-email-m.szyprowski@samsung.com>
 <037301cd2e90$529112e0$f7b338a0$%kim@samsung.com>
 <CAH9JG2V_9RVPvEHodDD422r=o4QxHcrMO-YXv2KUGYeys=ZjqA@mail.gmail.com>
 <201205101348.20870.arnd@arndb.de>
 <CAH9JG2U83+q9NKuvZV4s_iHvDTrQ-RCEqx=9L9uwqiMhYMSiHA@mail.gmail.com>
Message-ID: <045401cd2f62$210f3e40$632dbac0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OK, I thought again and talked to some guys. It's okay to add updated to the
non-dt board files on exynos4 for now. I know, until there is dt coverage
for more drivers, actually it will be difficult to build/support a complete
system with only dt support.

Note, we need to keep adding more and more support for dt for exynos4 and
exynos5. Then only we can stop the development of non-dt board files.

Thanks for many opinions about this and if any objections, feel free to
contact me.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

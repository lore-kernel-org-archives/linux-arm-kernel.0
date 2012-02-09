From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 09 Feb 2012 20:31:17 +0900
Subject: [PATCH 5/9] ARM: EXYNOS: add board file for SMDK5250
In-Reply-To: <20120201093423.GA3002@mudshark.cambridge.arm.com>
References: <1328024354-4277-1-git-send-email-kgene.kim@samsung.com>
 <1328024354-4277-6-git-send-email-kgene.kim@samsung.com>
 <CAH9JG2UZ9HxXsvmTh8Gqf5EpzS2sLSH_v8TWjKeBL8z7hR++Mg@mail.gmail.com>
 <CAOesGMgNdDdzsSBtopu7hu0xavFDSBnw0TW1MrN25C7FO+j8AQ@mail.gmail.com>
 <20120201093423.GA3002@mudshark.cambridge.arm.com>
Message-ID: <069401cce71e$56bffe80$043ffb80$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon wrote:
> 
> On Wed, Feb 01, 2012 at 08:50:23AM +0000, Olof Johansson wrote:
> > On Tue, Jan 31, 2012 at 8:20 PM, Kyungmin Park <kmpark@infradead.org>
> wrote:
> > > As I remember only DT based board file is acceptable for mainline?
> >
> > For a new SoC family like 5250 it would be much preferred to only add
> > device-tree enabled boards.
> 
As I commented, I'd like to support both dt and non-dt for EXYNOS5250 and
I'm saying EXYNOS5250 DT patches will be submitted next time again.

> As I mentioned in an earlier thread, it would also solve the problem of
> enumerating the CPU topology on A15 (without resorting to flaky hacks in
> core code).
> 
Will, yes I know that. But I think, seems A15 SMP (not MP) can be supported?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

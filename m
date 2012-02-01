From: olof@lixom.net (Olof Johansson)
Date: Wed, 1 Feb 2012 00:50:23 -0800
Subject: [PATCH 5/9] ARM: EXYNOS: add board file for SMDK5250
In-Reply-To: <CAH9JG2UZ9HxXsvmTh8Gqf5EpzS2sLSH_v8TWjKeBL8z7hR++Mg@mail.gmail.com>
References: <1328024354-4277-1-git-send-email-kgene.kim@samsung.com>
 <1328024354-4277-6-git-send-email-kgene.kim@samsung.com>
 <CAH9JG2UZ9HxXsvmTh8Gqf5EpzS2sLSH_v8TWjKeBL8z7hR++Mg@mail.gmail.com>
Message-ID: <CAOesGMgNdDdzsSBtopu7hu0xavFDSBnw0TW1MrN25C7FO+j8AQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 31, 2012 at 8:20 PM, Kyungmin Park <kmpark@infradead.org> wrote:
> As I remember only DT based board file is acceptable for mainline?

For a new SoC family like 5250 it would be much preferred to only add
device-tree enabled boards.


-Olof

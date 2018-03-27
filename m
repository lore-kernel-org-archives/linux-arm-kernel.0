From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Mar 2018 15:12:31 +0200
Subject: [GIT PULL 6/7] arm64: Default configuration updates for v4.17-rc1
In-Reply-To: <20180316141850.4876-6-thierry.reding@gmail.com>
References: <20180316141850.4876-1-thierry.reding@gmail.com>
 <20180316141850.4876-6-thierry.reding@gmail.com>
Message-ID: <CAK8P3a0-3SJoWjEC3mGRCsfXQSfsC-wwmpxHuG2fzgGjQ-1fTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2018 at 3:18 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> arm64: Default configuration updates for v4.17-rc1
>
> Enable the BPMP thermal and CPU frequency drivers as well as make sure
> that the Tegra SMMU is enabled by default because there's no fun without
> it. Also enable initial Tegra194 support.

Pulled into next/soc, thanks!

      Arnd

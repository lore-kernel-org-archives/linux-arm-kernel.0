From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 26 Apr 2018 16:48:46 +0200
Subject: [GIT PULL] firmware: scmi: fixes for v4.17
In-Reply-To: <20180417100949.GB16146@e107533-lin>
References: <20180417100949.GB16146@e107533-lin>
Message-ID: <CAK8P3a3jO2sJi7qkt-VQXZzKYyxhC9b55Z0JuJ30=SmzpD4Rmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2018 at 12:09 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
>
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
>
> are available in the git repository at:
>
>   ssh://git at gitolite.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/scmi-fixes-4.17
>
> for you to fetch changes up to d27a3c3436a7f68f3affd7991cb4a68e91dd747e:
>
>   firmware: arm_scmi: remove redundant null check on array (2018-04-16 10:15:58 +0100)
>
> ----------------------------------------------------------------
> SCMI fix for v4.17
>
> A single patch eliminating the redundant null pointer check detected
> by CoverityScan("Array compared against 0")

Pulled into fixes, thanks!

       Arnd

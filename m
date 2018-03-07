From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Mar 2018 16:44:33 +0100
Subject: [GIT PULL] firmware: arm_scpi: updates for v4.17
In-Reply-To: <20180301162318.GB1752@e107155-lin>
References: <20180301162318.GB1752@e107155-lin>
Message-ID: <CAK8P3a3CPs6PaxvrJCDsrO8NBSZhOwwTArVYr4=cW16XvH-7WA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 1, 2018 at 5:23 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:

> ARM SCPI updates/cleanups for v4.17
>
> 1. Fixes to get rid of sparse warnings
> 2. Use of FIELD_GET and GENMASK for better subfields handling
> 3. Make mbox_free_channels device-managed helping in removing unnecessary code
> 4. Various other cleanups to simplify and improve code readability
>
> Note that similar set of changes were merged in v4.15, however got reverted
> through the commit 81faa5566864 ("firmware: arm_scpi: Revert updates made
> during v4.15 merge window") for reasons mentioned in that commit.
>
> This is the resend with the culprit patch removed. Kevin Hilman tested this
> series on Amlogic and reported it to be fine.

Pulled into next/drivers, thanks!

         Arnd

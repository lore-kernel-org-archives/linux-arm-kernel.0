From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Oct 2017 17:42:18 +0200
Subject: [GIT PULL] i.MX fixes for 4.14
In-Reply-To: <20171016073851.GA8320@x250>
References: <20171016073851.GA8320@x250>
Message-ID: <CAK8P3a3Fmt8fhFUW9r2ttRUVMxZQ4qjr7nMvx=6qtYxDamxAKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 16, 2017 at 9:38 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> ----------------------------------------------------------------
> i.MX fixes for 4.14:
>  - Fix the legacy PCI interrupt numbers for i.MX7.  The numbers were
>    wrongly coded in an inverted order than what Reference Manual tells.
>    It causes problem for PCI devices using legacy interrupt.
>

Pulled into fixes, thanks!

     Arnd

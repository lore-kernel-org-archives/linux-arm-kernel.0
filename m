From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Mar 2018 15:07:52 +0100
Subject: [GIT PULL] ARM: at91: DT for 4.17
In-Reply-To: <20180310052601.GA6294@piout.net>
References: <20180310052601.GA6294@piout.net>
Message-ID: <CAK8P3a0LOjORi7f_YEp+zk28CTrvo7RLS-BmnooRL11MH2nh5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 10, 2018 at 6:26 AM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> Arnd, Olof,
>
> Not much this cycle, mainly changes on the Axentia boards from Peter and
> a cleanup from Bartosz.
...
> AT91 DT for 4.17:
>
>  - use 'atmel' as at24 manufacturer
>  - device addition and fixes for axentia boards
>  - fix sama5d4 pinctrl compatible

I added the first sentence to the commit log and pulled it into next/dt.
Generally speaking, I find those cleartext descriptions are more helpful
than a list that repeats the list of commits.

      Arnd

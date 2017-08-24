From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 Aug 2017 13:13:07 +0200
Subject: [GIT PULL] ARM: dts: aspeed: Changes for 4.14
In-Reply-To: <CACPK8XerZV+3RbxofpghWioYC68kK531aQQ_Jc8ZYLrjjCUqjQ@mail.gmail.com>
References: <CACPK8XerZV+3RbxofpghWioYC68kK531aQQ_Jc8ZYLrjjCUqjQ@mail.gmail.com>
Message-ID: <CAK8P3a1i0qJ+3Ty+QejDW5Pbyx24D9JjxrZuvhx8-1Hj2G1h1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2017 at 6:14 AM, Joel Stanley <joel@jms.id.au> wrote:
> Hi Arnd and Olof,
> Aspeed devicetree updates for 4.14
>
>  - fix to expose the full flash windows on ast2400.
>

Pulled into next/dt, thanks! Can you explain the CONFIG_VMSPLIT_2G
requirement mentioned in the changelog here? Will it stop working with
a normal multiplatform configuration that uses VMSPLIT_3G, or just
have no effect?

      Arnd

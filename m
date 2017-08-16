From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Aug 2017 23:46:26 +0200
Subject: [GIT PULL] arm64: dts: juno: Updates for v4.14
In-Reply-To: <d33155aa-9925-1a65-ac82-d7cb5e7edd53@arm.com>
References: <d33155aa-9925-1a65-ac82-d7cb5e7edd53@arm.com>
Message-ID: <CAK8P3a3KX0iDGpWH-CYpwiuz1a2n07MdYC6zkZ0HUch0_xWm2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 6:20 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> ----------------------------------------------------------------
> ARMv8 Vexpress/Juno DT updates for v4.14
>
> 1. Replaces old coresight ATB programmable replicator compatible with
>    new and more generic one
>
> 2. Replaces incorrect usage of underscores for device node names in the
>    device tree with hyphen

Pulled into next/dt64.

Regarding the change of the compatible string for the replicator, can you
confirm that nothing ever used the old string?

In doubt, it might be better to keep both strings present for
backward-compatibility.

       Arnd

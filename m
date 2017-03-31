From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 Mar 2017 11:53:17 +0200
Subject: [GIT PULL 3/7] Broadcom devicetree-arm64 changes for 4.12
In-Reply-To: <20170324175807.27272-3-f.fainelli@gmail.com>
References: <20170324175807.27272-1-f.fainelli@gmail.com>
 <20170324175807.27272-3-f.fainelli@gmail.com>
Message-ID: <CAK8P3a2_DFkmf76OmES4422sfUnti8G33dB6db4jG=X7Kv2_PQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 6:58 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM64-based SoCs Device Tree updates for
> 4.12, please pull the following:
>
> - Rob enables the cryptographic block on Northstar 2 (SPU) by adding the proper
>   Device Tree nodes
>
> - Jon replaces all occurences of: status = "ok" with status = "okay" to better
>   conform to the Device Tree specification

Pulled into next/dt64, thanks!

        Arnd

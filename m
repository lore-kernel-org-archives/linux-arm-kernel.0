From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Feb 2018 15:29:39 +0100
Subject: [PATCH v10 2/3] arm: dts: add Nuvoton NPCM750 device tree
In-Reply-To: <20180213200959.160157-3-brendanhiggins@google.com>
References: <20180213200959.160157-1-brendanhiggins@google.com>
 <20180213200959.160157-3-brendanhiggins@google.com>
Message-ID: <CAK8P3a2_2sQYCaUK-thBxTJ+VhQiw4AcDgwJoyEG=Ssnr=PtQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 9:09 PM, Brendan Higgins
<brendanhiggins@google.com> wrote:

> +
> +Enable method name:    "nuvoton,npcm7xx-smp"
> +Compatible machines:   "nuvoton,npcm750"
> +Compatible CPUs:       "arm,cortex-a9"
> +Related properties:    (none)
> +
> +Note:
> +This enable method needs valid nodes compatible with "arm,cortex-a9-scu" and
> +"nuvoton,npcm750-gcr".
> +
> +Example:
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               enable-method = "nuvoton,npcm7xx-smp";

It seems you changed the DT files, but forgot to update the binding to match.

Otherwise it looks al good to me.

       Arnd

From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 27 Feb 2018 12:28:38 -0300
Subject: [PATCH] ARM: dts: imx7: add CPU PMU support
In-Reply-To: <20180227151610.21887-1-stefan@agner.ch>
References: <20180227151610.21887-1-stefan@agner.ch>
Message-ID: <CAOMZO5DD1atSkWjGR0b1VVfQWdsNsL2GN6Z0yJ7YmM38vQSUxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 12:16 PM, Stefan Agner <stefan@agner.ch> wrote:
> Enable support for ARM Performance Monitoring Units available
> on the Cortex-A7 CPU. There is only a single interrupt for the
> PMU in both variants of the family, i.MX 7Solo and 7Dual.
>
> Tested with perf on a i.MX 7Dual:
>   hw perfevents: enabled with armv7_cortex_a7 PMU driver, 5 counters available
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

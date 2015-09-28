From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 28 Sep 2015 20:37:16 -0300
Subject: [PATCH] ARM: dts: imx7d: Fix UART2 base address
In-Reply-To: <20150926050154.GF3529@tiger>
References: <1443122292-29385-1-git-send-email-festevam@gmail.com>
 <20150926050154.GF3529@tiger>
Message-ID: <CAOMZO5BoTRj-wsN37=Tk5CQO8DkuZaUuRCLVe6Y=+waZGDJxgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Sat, Sep 26, 2015 at 2:01 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Thu, Sep 24, 2015 at 04:18:12PM -0300, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> The UART2 memory space starts at address 0x30890000 (UART2_URXD).
>>
>> Fix it so that UART2 can be used.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>
> Frank, can you confirm it?

This patch uses the UART2 base address as stated in the MX7D Reference Manual.

It has also been tested on a custom board.

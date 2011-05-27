From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 27 May 2011 15:16:07 -0300
Subject: [PATCH] ARM: imx/mach-apf9328: Simplify UART0 registration
In-Reply-To: <20110510165802.04ed1b9b@trabucayre.com>
References: <1305037260-31131-1-git-send-email-fabio.estevam@freescale.com>
	<20110510165802.04ed1b9b@trabucayre.com>
Message-ID: <BANLkTimi4XgDZiz-bXz0EQkSiEwnnjKtNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Tue, May 10, 2011 at 11:58 AM, gwenhael.goavec
<gwenhael.goavec-merou@armadeus.com> wrote:
> On Tue, 10 May 2011 11:21:00 -0300
> Fabio Estevam <fabio.estevam@freescale.com> wrote:
>
>> As no flag is passed into UART0 platform data, pass NULL argument
>> when registering UART0.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> Acked-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>

Ping?

Regards,

Fabio Estevam

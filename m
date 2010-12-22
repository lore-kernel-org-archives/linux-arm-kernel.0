From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 22 Dec 2010 11:25:01 -0200
Subject: [PATCH 1/3] ARM: mx3/mx35_3ds: Add USB OTG Host mode
In-Reply-To: <4D11A2AA.80300@compulab.co.il>
References: <1292961521-31539-1-git-send-email-fabio.estevam@freescale.com>
	<4D11A2AA.80300@compulab.co.il>
Message-ID: <AANLkTinaKUgsc+wPSQtJRMKr3zzhRgkDOGMa58pJAyc4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Igor,

On Wed, Dec 22, 2010 at 5:03 AM, Igor Grinberg <grinberg@compulab.co.il> wrote:
...
>> +#if defined(CONFIG_USB_ULPI)
>> +static struct mxc_usbh_platform_data otg_pdata __initdata = {
>> + ? ? .portsc = MXC_EHCI_MODE_UTMI,
>> + ? ? .flags ?= MXC_EHCI_INTERNAL_PHY,
>> +};
>> +
>
> I don't know much about mx3, but the above looks confusing. A typo?

You are right. It does not depend on ULPI. Will remove the ULPI dependencies.

Same applies for the other patch you commented.

Thanks,

Fabio Estevam

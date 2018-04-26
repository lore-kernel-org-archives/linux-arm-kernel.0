From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 26 Apr 2018 03:21:21 -0300
Subject: [PATCH V4 3/6] ARM: dts: imx6sx-sabreauto: add IO expander
 max7310 support
In-Reply-To: <AM3PR04MB13150654494B8D251988F76CF58E0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1524634571-5914-1-git-send-email-Anson.Huang@nxp.com>
 <1524634571-5914-3-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5Dm6rcEe=zAJ9_nqKce3g2tdyWPqb=Uv-N5nfc_96jc-g@mail.gmail.com>
 <AM3PR04MB13150654494B8D251988F76CF58E0@AM3PR04MB1315.eurprd04.prod.outlook.com>
Message-ID: <CAOMZO5AZLbUoL7FWgUFA7qc3q3wcz9UBLSQhMXXkUJeiRz8X4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 12:06 AM, Anson Huang <anson.huang@nxp.com> wrote:

> MAX7310 pins are for PCIe, CAN, MLB. GPS etc., these modules are NOT enabled yet, so
> I can NOT test it, I think we should add MAX7310 users when these modules are enabled,
> ethernet PHY is NOT controlled by it.

You said previously that MAX7310 also controls the Ethernet PHY. Is
the vendor dts wrong then?

If there are no MAX7310 users, why are you adding support for MAX7310 then?

Confused.

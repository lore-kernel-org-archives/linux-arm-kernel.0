From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 24 Apr 2018 09:22:52 -0300
Subject: [PATCH 4/5] ARM: dts: imx6sx-sabreauto: add fec support
In-Reply-To: <AM3PR04MB131566E1C8033D256686F192F5880@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1524455219-6736-1-git-send-email-Anson.Huang@nxp.com>
 <1524455219-6736-4-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5CDAQtw7Q6NgSzKP4ogaqRaGSE0A+st1iqZ=cQsK49moQ@mail.gmail.com>
 <AM3PR04MB131566E1C8033D256686F192F5880@AM3PR04MB1315.eurprd04.prod.outlook.com>
Message-ID: <CAOMZO5Dm=MFRoh=y54Qf2RrncWfQPTUJ2ZNfvYnUD=idp8RPNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

On Mon, Apr 23, 2018 at 11:09 PM, Anson Huang <anson.huang@nxp.com> wrote:

> Ah, yes, thanks for pointing out this issue, I just removed it and the function is still working,
> already sent out V2 patch set, thanks.

So now maybe it is working only because the bootloader activated this
GPIO, which is not good.

I don't have access to the mx6sx sabreauto schematics to verify  where
&max7322 0 connects to, but it would be better to make sure that you
activate this pin in dts if it is needed for Ethernet, without relying
on the bootloader.

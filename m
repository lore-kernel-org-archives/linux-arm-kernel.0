From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 10 Apr 2017 12:48:30 +0200
Subject: [v3, 0/7] Add SD UHS-I and eMMC HS200 support for eSDHC
In-Reply-To: <DB6PR0401MB253627A0ABBF6DA9EC063A84F8010@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <1490600982-5410-1-git-send-email-yangbo.lu@nxp.com>
 <DB6PR0401MB253627A0ABBF6DA9EC063A84F8010@DB6PR0401MB2536.eurprd04.prod.outlook.com>
Message-ID: <CAPDyKFpN-+7mxxeBHEELROWsn275Mec6unDHdnY3Gsz3oKT9pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 April 2017 at 10:20, Y.B. Lu <yangbo.lu@nxp.com> wrote:
> Hi Andrian and Uffe,
>
> Do you have any comments on MMC patches?
> Could you help to merge the mmc patches if there is no changes requested?

I am waiting for Adrian's acks.

>
> Regarding to the dts patches, I have some more platforms to support.
> So I'd like to drop them currently, and send them all to arm mailing list for reviewing.

If it's new bindings/compatibles, the DT doc changes needs to be
discussed and agreed upon first. Actual changes to the DTS files,
should preferably go via the arm soc tree.

Kind regards
Uffe

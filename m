From: yangbo.lu@nxp.com (Y.B. Lu)
Date: Tue, 11 Apr 2017 05:24:13 +0000
Subject: [v3, 0/7] Add SD UHS-I and eMMC HS200 support for eSDHC
In-Reply-To: <CAPDyKFpN-+7mxxeBHEELROWsn275Mec6unDHdnY3Gsz3oKT9pw@mail.gmail.com>
References: <1490600982-5410-1-git-send-email-yangbo.lu@nxp.com>
 <DB6PR0401MB253627A0ABBF6DA9EC063A84F8010@DB6PR0401MB2536.eurprd04.prod.outlook.com>
 <CAPDyKFpN-+7mxxeBHEELROWsn275Mec6unDHdnY3Gsz3oKT9pw@mail.gmail.com>
Message-ID: <DB6PR0401MB2536E5DEA75B7A1330D0FC39F8000@DB6PR0401MB2536.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uffe and Adrian,

Thanks for your quick response.
I dropped the dts patches and would send the new version mmc patchset which addressed Adrian's comments.
The dts patches would be sent separately to arm soc and will not have new bindings/compatibles to discuss.

Thanks.


Best regards,
Yangbo Lu

> -----Original Message-----
> From: Ulf Hansson [mailto:ulf.hansson at linaro.org]
> Sent: Monday, April 10, 2017 6:49 PM
> To: Y.B. Lu
> Cc: linux-mmc at vger.kernel.org; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Adrian Hunter; Rob Herring; Mark Rutland;
> Catalin Marinas; Will Deacon; Xiaobo Xie
> Subject: Re: [v3, 0/7] Add SD UHS-I and eMMC HS200 support for eSDHC
> 
> On 10 April 2017 at 10:20, Y.B. Lu <yangbo.lu@nxp.com> wrote:
> > Hi Andrian and Uffe,
> >
> > Do you have any comments on MMC patches?
> > Could you help to merge the mmc patches if there is no changes
> requested?
> 
> I am waiting for Adrian's acks.
> 
> >
> > Regarding to the dts patches, I have some more platforms to support.
> > So I'd like to drop them currently, and send them all to arm mailing
> list for reviewing.
> 
> If it's new bindings/compatibles, the DT doc changes needs to be
> discussed and agreed upon first. Actual changes to the DTS files, should
> preferably go via the arm soc tree.
> 
> Kind regards
> Uffe

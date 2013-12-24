From: b38343@freescale.com (Robin Gong)
Date: Tue, 24 Dec 2013 11:07:04 +0800
Subject: [PATCH 1/2] ARM: dts: imx6qdl-sabresd: Add PFUZE100 support
In-Reply-To: <CAOMZO5C-0g+LrwqnmJA_Uwyw43UAZSGnmY7JPcLy3nySTZ+GGw@mail.gmail.com>
References: <1387826937-9734-1-git-send-email-festevam@gmail.com>
 <20131224025547.GC27081@Robin-OptiPlex-780>
 <CAOMZO5C-0g+LrwqnmJA_Uwyw43UAZSGnmY7JPcLy3nySTZ+GGw@mail.gmail.com>
Message-ID: <20131224030703.GE27081@Robin-OptiPlex-780>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sw2_reg: sw2 {
		regulator-min-microvolt = <800000>;
		regulator-max-microvolt = <3300000>;
}
On Tue, Dec 24, 2013 at 12:55:09AM -0200, Fabio Estevam wrote:
> On Tue, Dec 24, 2013 at 12:55 AM, Robin Gong <b38343@freescale.com> wrote:
> 
> >> +                     sw2_reg: sw2 {
> >> +                             regulator-min-microvolt = <800000>;
> >> +                             regulator-max-microvolt = <3950000>;
> > Should be 3300000, right?
> 
> Actually it should be:
> 
>                      sw2_reg: sw2 {
>                              regulator-min-microvolt = <400000>;
>                              regulator-max-microvolt = <3300000>;
> 
> Do you agree?
> 
> Regards,
> 
> Fabio Estevam
> 
> 

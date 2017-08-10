From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 10 Aug 2017 13:24:11 +0200
Subject: [PATCH 2/2] ARM: dts: r8a7743: Add IIC cores to dtsi
In-Reply-To: <20170810080121.GE16647@verge.net.au>
References: <1502196418-31341-1-git-send-email-biju.das@bp.renesas.com>
 <12d923ba-184c-ef59-f27b-41a7592a5f93@cogentembedded.com>
 <20170810080121.GE16647@verge.net.au>
Message-ID: <20170810112411.GA4380@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > >+		i2c6: i2c at e60b0000 {
> > 
> >    I'd use iic0 as the label.
> 
> I have no preference here other than that we try to be consistent
> in DT for different R-Car SoCs. Wolfram, do you have an opinion on this?

Back then, for M2-W, I decided to go with the schematics/datasheets.
And those mentioned i2c6 rather than iic0. For that reason, the comment

"/* The memory map in the User's Manual maps the cores to bus numbers */"

exists in r8a7791.dtsi. Dunno the manual of this SoC here.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170810/bb3d03e1/attachment.sig>

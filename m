From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 20 Nov 2015 14:54:02 +0100
Subject: VF610 broken by pinctrl: freescale: imx: allow mux_reg offset zero
In-Reply-To: <BN3PR03MB1509A4198D2EBD250396546AA81E0@BN3PR03MB1509.namprd03.prod.outlook.com>
References: <20151115024409.GB2194@lunn.ch>
 <BN3PR03MB1509A4198D2EBD250396546AA81E0@BN3PR03MB1509.namprd03.prod.outlook.com>
Message-ID: <20151120135402.GE5044@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Anyway, it looks like -rc1 is going to be broken on VF610 for some boards,
> > because this pin is the Ethernet clock input/output. Please can you get it fixed
> > for -rc2?
> > 
> [Adrian] Sure let me take a look at this.

Hi Adrian

Do you have a fix for this regression yet? I'm happy to test patches.

Thanks
	Andrew

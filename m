From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 30 Jul 2015 17:41:28 +0100
Subject: [RFC] arm64: defconfig: enable 48-bit VA by default
In-Reply-To: <CY1PR0301MB0748FA3A10AFA9BFC1AB0A39878B0@CY1PR0301MB0748.namprd03.prod.outlook.com>
References: <CY1PR0301MB07488D6DC5F0B171D6B290E187830@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <55B0E1AD.60409@arm.com>
 <BY2PR0301MB0743CBCFC5476E39A5D1EC0B878C0@BY2PR0301MB0743.namprd03.prod.outlook.com>
 <CAKv+Gu9LHBd7wM6P4H0X5WigzDETtpr2++_Ebo=adg5QtTOW2w@mail.gmail.com>
 <BY2PR0301MB074300C5F31701D9211827F0878C0@BY2PR0301MB0743.namprd03.prod.outlook.com>
 <20150730101358.GA30796@e104818-lin.cambridge.arm.com>
 <CY1PR0301MB074850E27D5D298D1B8495D2878B0@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <20150730161210.GE407@e104818-lin.cambridge.arm.com>
 <CY1PR0301MB0748FA3A10AFA9BFC1AB0A39878B0@CY1PR0301MB0748.namprd03.prod.outlook.com>
Message-ID: <20150730164128.GF407@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 30, 2015 at 04:32:19PM +0000, Stuart Yoder wrote:
> > -----Original Message-----
> > From: Catalin Marinas [mailto:catalin.marinas at arm.com]
> >
> > For the time being, I would keep defconfig to 39-bit VA. If we start
> > seeing systems with lots of RAM (over 256GB), we'll probably change the
> > defconfig.
> 
> Somone who follows the "Principles" doc "correctly" will hit an issue
> with the linear memory map after 32GB of RAM, right?   2 GB in 1st alias,
> 30 GB in 2nd alias, and rest at the 544 GB offset.

Right (though I still don't like it but, well...).

-- 
Catalin

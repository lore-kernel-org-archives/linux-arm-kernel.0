From: anilkumar.v@ti.com (Kumar, Anil)
Date: Tue, 15 Jan 2013 10:36:55 +0000
Subject: [PATCH V2 3/3] ARM: davinci: da850: add NAND driver entries
In-Reply-To: <50EEB1C1.9060306@ti.com>
References: <1357633220-29827-1-git-send-email-anilkumar.v@ti.com>
 <1357633220-29827-4-git-send-email-anilkumar.v@ti.com>
 <50ED66F2.8050006@ti.com>
 <F3DBB1B3EF102E4994C89758CFCA32412B80CA@DBDE01.ent.ti.com>
 <50EEB1C1.9060306@ti.com>
Message-ID: <F3DBB1B3EF102E4994C89758CFCA32412B96F9@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 17:49:13, Nori, Sekhar wrote:
> On 1/10/2013 1:07 PM, Kumar, Anil wrote:
> > On Wed, Jan 09, 2013 at 18:17:46, Nori, Sekhar wrote:
> 
> > I do not think that it is good idea to move NAND pin mux information
> > into da850.dtsi because this information is evm specific.
> > if we will use this approach then we must use the same approach for
> > other modules also as ASoC etc.   
> 
> Why do you consider this EVM specific. IOW, which pins do you see
> changing on another board? BTW, if there are additional pins needed than
> what are listed, we can always add more pinux entries in the .dts files.
> The pins present in dtsi file should the base case.
 
Ok, we can use this approach for DaVinci as its SoC modules do not
have multiple pin configuration option. I will do the changes in 
next patch series.

Thanks,
Anil

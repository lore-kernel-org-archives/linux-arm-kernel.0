From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 10 Jan 2013 17:49:13 +0530
Subject: [PATCH V2 3/3] ARM: davinci: da850: add NAND driver entries
In-Reply-To: <F3DBB1B3EF102E4994C89758CFCA32412B80CA@DBDE01.ent.ti.com>
References: <1357633220-29827-1-git-send-email-anilkumar.v@ti.com>
 <1357633220-29827-4-git-send-email-anilkumar.v@ti.com>
 <50ED66F2.8050006@ti.com>
 <F3DBB1B3EF102E4994C89758CFCA32412B80CA@DBDE01.ent.ti.com>
Message-ID: <50EEB1C1.9060306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/10/2013 1:07 PM, Kumar, Anil wrote:
> On Wed, Jan 09, 2013 at 18:17:46, Nori, Sekhar wrote:

> I do not think that it is good idea to move NAND pin mux information
> into da850.dtsi because this information is evm specific.
> if we will use this approach then we must use the same approach for
> other modules also as ASoC etc.   

Why do you consider this EVM specific. IOW, which pins do you see
changing on another board? BTW, if there are additional pins needed than
what are listed, we can always add more pinux entries in the .dts files.
The pins present in dtsi file should the base case.

Thanks,
Sekhar

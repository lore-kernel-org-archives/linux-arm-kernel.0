From: nerv@dawncrow.de (=?UTF-8?B?QW5kcsOpIEhlbnRzY2hlbA==?=)
Date: Sat, 04 May 2013 17:54:37 +0200
Subject: [PATCHv2] arm: Preserve TPIDRURW on context switch
In-Reply-To: <5183D6C3.8090402@arm.com>
References: <517168BB.3070903@dawncrow.de>
 <20130422143616.GP14496@n2100.arm.linux.org.uk>
 <20130422151836.GA15665@mudshark.cambridge.arm.com>
 <5175A697.3080308@dawncrow.de>
 <20130423091536.GB17593@mudshark.cambridge.arm.com>
 <51770E4E.2040003@dawncrow.de>
 <20130424094251.GA21850@mudshark.cambridge.arm.com>
 <5182C480.3080001@dawncrow.de> <5183819E.50308@arm.com>
 <20130503095547.GD18614@n2100.arm.linux.org.uk> <5183D6C3.8090402@arm.com>
Message-ID: <51852F3D.5000802@dawncrow.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 03.05.2013 17:24, schrieb Jonathan Austin:
> Hi Russell,
> 
> Thanks for the comments - you're right about the 'switch_tls'
> being more appropriate - needed to take a step back to see that.
> 
> I've got a few questions, added inline.
> 
> Andr?, Assuming I've understood things okay, there's a patch that
> uses Russell's asm stuff (with minor modifications, see the questions)
> and includes the C-world changes too. Perhaps you could see that it
> solves your problem?

I'll test it tomorrow with my test tool and Wine.
FWIW i hacked together a test tool and it's available at https://github.com/AndreRH/tpidrurw-test

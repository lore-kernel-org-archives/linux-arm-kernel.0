From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 08 Dec 2010 12:30:56 -0800
Subject: [PATCHv3 2/4] ARM: Allow machines to override __delay()
In-Reply-To: <1291839992.12568.31.camel@c-dwalke-linux.qualcomm.com>
References: <1291783128-27520-1-git-send-email-sboyd@codeaurora.org>	
	<1291783128-27520-3-git-send-email-sboyd@codeaurora.org>	
	<1291836162.12568.17.camel@c-dwalke-linux.qualcomm.com>	
	<4CFFE965.30906@codeaurora.org>
	<1291839992.12568.31.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <4CFFEB00.5090807@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/08/2010 12:26 PM, Daniel Walker wrote:
>
> The last time I thought you said there was no size change ? My tests
> showed a decrease ..

Oh, right. There was no size change when I moved __delay() into the
header in addition to the others.

>
> What compiler optimizations are you talking about 

See

Subject: Weirdo gcc 4.3.x behaviour
Message-ID: <20101121191148.GA12234@n2100.arm.linux.org.uk>

and

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=29950

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

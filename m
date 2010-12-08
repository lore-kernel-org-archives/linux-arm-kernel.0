From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 08 Dec 2010 13:07:59 -0800
Subject: [PATCHv3 2/4] ARM: Allow machines to override __delay()
In-Reply-To: <4CFFEB00.5090807@codeaurora.org>
References: <1291783128-27520-1-git-send-email-sboyd@codeaurora.org>
	<1291783128-27520-3-git-send-email-sboyd@codeaurora.org>
	<1291836162.12568.17.camel@c-dwalke-linux.qualcomm.com>
	<4CFFE965.30906@codeaurora.org>
	<1291839992.12568.31.camel@c-dwalke-linux.qualcomm.com>
	<4CFFEB00.5090807@codeaurora.org>
Message-ID: <1291842479.12568.39.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-12-08 at 12:30 -0800, Stephen Boyd wrote:
> On 12/08/2010 12:26 PM, Daniel Walker wrote:
> >
> > The last time I thought you said there was no size change ? My tests
> > showed a decrease ..
> 
> Oh, right. There was no size change when I moved __delay() into the
> header in addition to the others.

So is there a problem with doing the inlining then ? If you get the same
size kernel, then that seems like a lateral move in your case.

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

From: holler@ahsoftware.de (Alexander Holler)
Date: Wed, 22 Jun 2011 08:23:44 +0200
Subject: [PATCH] USB: ehci: use packed,aligned(4) instead of removing
	the packed attribute
In-Reply-To: <alpine.LFD.2.00.1106211636190.2142@xanadu.home>
References: <Pine.LNX.4.44L0.1106211054460.2327-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.1106211636190.2142@xanadu.home>
Message-ID: <4E018A70.1060706@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 21.06.2011 22:41, Nicolas Pitre wrote:

> ... and also in this case, I was talking about proper use of the packed 
> attribute in general, not at all about a specific case.  I wanted to 
> provide a broader view to some people who expressed doubts and 
> misunderstanding in the hope that the archive could keep this knowledge 
> base available.
> 
> I apologize if that wasn't clear to you.

If you meant the abomination writing one, thanks, but I never expressed
doubts or misunderstandings.

I said doubts may arise because the standard (C99) doesn't say anything
about if or how structs are packed (or aligned).

Alexander

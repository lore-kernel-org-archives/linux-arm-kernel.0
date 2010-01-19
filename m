From: hvdmerwe@tmtservices.co.za (Hennie van der Merwe)
Date: Tue, 19 Jan 2010 07:48:47 +0200
Subject: [PATCH - 3rd attempt] ARM: Support for Embedian MXM-8x10 eval kit
In-Reply-To: <201001190737.59609.epeer@tmtservices.co.za>
References: <201001182134.14226.epeer@tmtservices.co.za>
	<20100118215124.GE8970@buzzloop.caiaq.de>
	<4B55400C.1050109@tmtservices.co.za>
	<201001190737.59609.epeer@tmtservices.co.za>
Message-ID: <4B5547BF.4010905@tmtservices.co.za>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Edwin,

Edwin Peer wrote:
> Indeed, those can't be made static. What I have done is make all the functions 
> we call in barebones_init() static and remove their declarations from the 
> header, since those are never optional.
>   
I don't agree. I think Eric's solution is very elegant without 
sacrificing flexibility.

Hennie
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hvdmerwe.vcf
Type: text/x-vcard
Size: 373 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100119/f868fc0e/attachment.vcf>

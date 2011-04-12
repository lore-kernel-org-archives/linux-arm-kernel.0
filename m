From: tixy@yxit.co.uk (Tixy)
Date: Tue, 12 Apr 2011 16:16:31 +0100
Subject: [PATCH 4/6] ARM: kprobes: Fix emulation of SXTB16, SXTB, SXTH,
	UXTB16,	UXTB and UXTH instructions
In-Reply-To: <4DA439E6.90906@ru.mvista.com>
References: <1302590726-3484-1-git-send-email-tixy@yxit.co.uk>
	<1302590726-3484-5-git-send-email-tixy@yxit.co.uk>
	<4DA439E6.90906@ru.mvista.com>
Message-ID: <1302621391.2489.2.camel@computer2.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-04-12 at 15:39 +0400, Sergei Shtylyov wrote:
>     Why use {} around single statements? checkpatch.pl used to warn about this...

It still does ;-)
I'll fix them.

-- 
Tixy

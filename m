From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 May 2015 16:24:37 +0200
Subject: [PATCH] ARM: fix BE8 module loading
In-Reply-To: <5559F5B4.9060401@arm.com>
References: <2205892.6d8Sa1bONm@wuerfel> <5559F5B4.9060401@arm.com>
Message-ID: <3386186.XWmJAAGsrg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 May 2015 15:22:44 Robin Murphy wrote:
> 
> Do you mean BE-32 here (and in the title)? That's the obsolete wacky 
> word-invariant one, BE-8 is the sensible* one that modern CPUs support.
> 
> Robin.
> 
> *as sensible as big-endian could ever be, at any rate 
> 

You are absolutely right, I've fixed  up the changelog accordingly now.

	Arnd

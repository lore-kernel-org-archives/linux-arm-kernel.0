From: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 17 Jul 2013 16:22:58 -0700
Subject: [PATCH -next 2/2] kbuild: fix for updated LZ4 tool with the new
 streaming format
In-Reply-To: <20130717223033.GF3385@free.fr>
References: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
 <20130716004727.b60b2c96.akpm@linux-foundation.org>
 <20130716005611.e4ccab02.akpm@linux-foundation.org>
 <201307161008.07643.yann.morin.1998@free.fr>
 <20130716180408.GA19863@merkur.ravnborg.org>
 <20130717211649.GA5619@merkur.ravnborg.org> <20130717223033.GF3385@free.fr>
Message-ID: <51E72752.9020206@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/17/2013 03:30 PM, Yann E. MORIN wrote:
> 
> At the very least we'd have to decide if this is available only for
> booleans/tristates, or for any type? Your implementation seems to make
> it valid for strings/ints, too.
> 

I feel the test should *export* a boolean.

It is worth noting that one of the things that keep getting brought up
as something that need this is gcc/binutils support for a specific feature.

	-hpa

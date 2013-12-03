From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Tue, 3 Dec 2013 15:55:47 +0000
Subject: [Xen-devel] [PATCH] xen/block: Correctly define structures in
 public headers on ARM32 and ARM64
In-Reply-To: <1386085745.13256.51.camel@kazak.uk.xensource.com>
References: <1386083382-7306-1-git-send-email-julien.grall@linaro.org>
 <529E039A02000078001097F5@nat28.tlf.novell.com>
 <529DF897.1080303@linaro.org>
 <1386085745.13256.51.camel@kazak.uk.xensource.com>
Message-ID: <20131203155547.669b8627@alan.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Just a random thought but what about using the CONFIG_$ARCH to define a
> more semantic name, like HAVE_4_BYTE_ALIGNED_QUAD_WORDS, or whichever
> terminology for an 8-byte type is appropriate in the context.
> 
> Maybe Linux even already has such a #define?

It doesn't need one. It's written in GNU C so we have __alignof__.

See

http://gcc.gnu.org/onlinedocs/gcc/Alignment.html

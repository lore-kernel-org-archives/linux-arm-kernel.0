From: smueller@chronox.de (Stephan =?ISO-8859-1?Q?M=FCller?=)
Date: Thu, 23 Mar 2017 14:06:22 +0100
Subject: Question - seeding the hw pseudo random number generator
In-Reply-To: <20170323094406.GA6848@gondor.apana.org.au>
References: <20170318092554.lggkhfg5eko23o3k@kozik-lap>
 <20170323082307.GB16625@Red> <20170323094406.GA6848@gondor.apana.org.au>
Message-ID: <25271998.F6jFv7Sebt@positron.chronox.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 23. M?rz 2017, 10:44:06 CET schrieb Herbert Xu:

Hi Herbert,

> On Thu, Mar 23, 2017 at 09:23:07AM +0100, Corentin Labbe wrote:
> > Problem with this conversion, a huge regression for user space.
> > Using hwrng is simple as cat /dev/hwrng.
> > Using algif_rng via AF_ALG is ... unusable for the moment.
> > Perhaps creating an user space tool (prng-tool which provide a cat
> > /dev/hwrng replacement) is mandatory before any convertion.
> Stephan may have a tool to do this.  Stephan?

Here is a suggestion for such a tool that I could add to libkcapi. Naturally, 
this code is only a demonstrator which lacks some features.

Ciao
Stephan
-------------- next part --------------
A non-text attachment was scrubbed...
Name: kcapi-rng.c
Type: text/x-csrc
Size: 3542 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170323/c0d8f632/attachment.bin>

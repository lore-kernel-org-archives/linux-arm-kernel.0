From: schwarzb@ipms.fraunhofer.de (Markus Schwarzenberg)
Date: Wed, 28 Oct 2009 17:26:34 +0100
Subject: smdk6400/S3C6400 failure on execution of init process
In-Reply-To: <20091028161028.GA2841@debian>
References: <20091028162037.22f2cb22@linpcd55> <20091028153916.GB2244@debian>
	<20091028165949.593b4d04@linpcd55> <20091028161028.GA2841@debian>
Message-ID: <20091028172634.0e325b77@linpcd55>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Oct 2009 21:40:28 +0530 Rabin Vincent <rabin@rab.in> wrote:

> > thanks, did this, the additional messages are (context see [*]):
> > > >   [1] endless-loop-no: obsolete system call 00000000.
> >   Code: e08f1001 e1a0c000 e3a0702d ef000000 (e3700a01) 
> 
> EABI-OABI mismatch.  Your userspace is EABI, but your kernel isn't.
> Enable "Use the ARM EABI to compile the kernel" in "Kernel Features".

thanks. this was the problem.

--
Markus 

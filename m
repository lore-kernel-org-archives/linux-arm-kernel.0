From: joe@perches.com (Joe Perches)
Date: Tue, 25 Oct 2016 10:29:41 -0700
Subject: [PATCH V2] arm64: Neaten show_regs, remove KERN_CONT
In-Reply-To: <20161025170745.GE8898@leverpostej>
References: <289fb30081aba03fec0c960e7334f707bf36c881.1477413522.git.joe@perches.com>
 <20161025170745.GE8898@leverpostej>
Message-ID: <1477416581.1998.10.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-10-25 at 18:07 +0100, Mark Rutland wrote:
> On Tue, Oct 25, 2016 at 09:40:26AM -0700, Joe Perches wrote:
> > commit db4b0710fae9 ("arm64: fix show_regs fallout from KERN_CONT changes")
> > corrected the KERN_CONT fallout from commit 4bcc595ccd80
> > ("printk: reinstate KERN_CONT for printing continuation lines"), but
> > the code still has unnecessary KERN_CONT uses.
> > 
> > Remove the KERN_CONT uses to avoid possible message interleaving.

Hey Mark.

Please fix it as you think appropriate.
No credit to me is necessary.

cheers, Joe

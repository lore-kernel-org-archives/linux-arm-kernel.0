From: joe@perches.com (Joe Perches)
Date: Mon, 22 Nov 2010 14:22:31 -0800
Subject: Weirdo gcc 4.3.x behaviour
In-Reply-To: <20101121191148.GA12234@n2100.arm.linux.org.uk>
References: <20101121191148.GA12234@n2100.arm.linux.org.uk>
Message-ID: <1290464551.27683.40.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2010-11-21 at 19:11 +0000, Russell King - ARM Linux wrote:
> Has anyone else seen weird behaviour from the gcc 4.3 branch?

It's not just the arm code generation.
It also happens x86 for 4.2.1

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=29950

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Feb 2013 10:50:52 +0000
Subject: [RFC PATCH 0/4] Add support for LZ4-compressed kernels
In-Reply-To: <510F16C9.2060901@oberhumer.com>
References: <1359179447-31118-1-git-send-email-kyungsik.lee@lge.com>
 <20130128142510.68092e10.akpm@linux-foundation.org>
 <alpine.LFD.2.02.1301282320430.6300@xanadu.home>
 <20130130102353.GA8925@sig21.net> <510F16C9.2060901@oberhumer.com>
Message-ID: <20130204105052.GA17786@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 03:02:49AM +0100, Markus F.X.J. Oberhumer wrote:
> At least akpm did approve the LZO update for inclusion into 3.7, but the code
> still has not been merged into the main tree.
>   > On 2012-10-09 21:26, Andrew Morton wrote:
>   > [...]
>   > The changes look OK to me.  Please ask Stephen to include the tree in
>   > linux-next, for a 3.7 merge.
> 
> Well, this probably means I have done a rather poor marketing.

I assume this code is sitting in *your* tree?  How do you think it gets
into mainline?

There is no automatic way that code from linux-next gets merged into
mainline.  That is up to the tree owner to make happen, either by getting
their tree into a parent maintainers tree, or if there is none, asking
Linus to pull your tree at the appropriate time.

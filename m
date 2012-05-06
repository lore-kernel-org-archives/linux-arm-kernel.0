From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 6 May 2012 11:11:41 +0100
Subject: [PATCH] ARM: SMP: prevent use of the console when using idmap_pgd
In-Reply-To: <20120505164933.GQ897@n2100.arm.linux.org.uk>
References: <1336180444-26563-1-git-send-email-ccross@android.com>
 <20120505164933.GQ897@n2100.arm.linux.org.uk>
Message-ID: <20120506101141.GI26481@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 05, 2012 at 05:49:33PM +0100, Russell King - ARM Linux wrote:
> I think this is fine.  Please put it in the patch system, thanks.

It looks like this bug affects v3.2 kernels as well - should it be marked
for the attention of the stable kernel team?

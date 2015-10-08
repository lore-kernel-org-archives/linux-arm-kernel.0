From: will.deacon@arm.com (Will Deacon)
Date: Thu, 8 Oct 2015 17:56:23 +0100
Subject: [PATCH v3] arm: Adding support for atomic half
 word exchange
In-Reply-To: <1357250509.710431444228599576.JavaMail.weblogic@epmlwas04a>
References: <1357250509.710431444228599576.JavaMail.weblogic@epmlwas04a>
Message-ID: <20151008165622.GP16807@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 02:36:41PM +0000, Sarbojit Ganguly wrote:
> Please have a look at this patch, please let me know if any modification
> is required.
> I have also submitted the same in your patch system.

There are some problems with the version in the patch system[1]:

  (1) You still have the changelog in the commit message (I asked you to
      remove this last time).

  (2) The commit message isn't line-wrapper appropriately

  (3) Your Signed-off-by line is truncated

The patch system does actually support git, so you can add:

  KernelVersion: 4.3-rc4

or whatever kernel you based your patch on somewhere after your SoB but
before the diff and then mail it to patchesATarm.linux.org.uk. You
probably also want to move the current patch to "superseded" so Russell
doesn't end up with two copies.

Will

[1] http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8442/1

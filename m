From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 19 Mar 2017 20:46:48 +0000
Subject: [PATCH] ARM: wire up statx syscall
In-Reply-To: <a1a1f1cccadb48d599ac9ac013ee7fab@svr-chch-ex1.atlnz.lc>
References: <20170317094204.15630-1-chris.packham@alliedtelesis.co.nz>
 <20170317095945.GY21222@n2100.armlinux.org.uk>
 <a1a1f1cccadb48d599ac9ac013ee7fab@svr-chch-ex1.atlnz.lc>
Message-ID: <20170319204648.GZ21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 19, 2017 at 08:12:48PM +0000, Chris Packham wrote:
> On 17/03/17 23:00, Russell King - ARM Linux wrote:
> > You obviously have not looked in linux-next.
> 
> No I haven't. But even now I see nothing in 
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

Hmm, looks like our regular linux-next updates stop at 10th March,
which is rather unfortunate.  If it was being updated, it would have
been in there.

If not, in order to see what I currently have merged for linux-next:

  http://git.armlinux.org.uk/cgit/linux-arm.git/log/?h=for-next

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

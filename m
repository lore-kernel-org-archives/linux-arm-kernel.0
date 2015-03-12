From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 13 Mar 2015 10:07:24 +1100
Subject: Update the clk tree for linux-next
In-Reply-To: <CAPtuhTiQvSUMnd7p8D27GQ=hw1MqPSoN9P6pArLpK96QfnGsVg@mail.gmail.com>
References: <CAPtuhTiQvSUMnd7p8D27GQ=hw1MqPSoN9P6pArLpK96QfnGsVg@mail.gmail.com>
Message-ID: <20150313100724.645fdd1a@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Thu, 12 Mar 2015 12:08:47 -0700 Mike Turquette <mturquette@linaro.org> wrote:
>
> Stephen Boyd has kindly agreed to co-maintain the clk framework with
> me and we have shared commit access to a new git tree at kernel.org:
> 
> https://git.kernel.org/cgit/linux/kernel/git/clk/linux.git/
> 
> Can you update linux-next to pull from this tree instead of the
> git.linaro.org address? They are currently mirrors but the
> git.kernel.org tree is the canonical tree from this day forth. The
> full path to pull from is:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next

OK, I have updated to use this and added Stephen as a contact for the
tree.  It is not quite in sync with the old tree at the moment.

For Stephen's benefit:

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgment of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window. 

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and 
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

-- 
Cheers,
Stephen Rothwell 
sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150313/542ea121/attachment-0001.sig>

From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 7 Mar 2014 09:37:55 +1100
Subject: Request inclusion of HYP mode cpu_resume fix into linux-next
In-Reply-To: <20140306184303.GA31279@e102568-lin.cambridge.arm.com>
References: <20140306184303.GA31279@e102568-lin.cambridge.arm.com>
Message-ID: <20140307093755.48783e33d163e0a900323a53@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On Thu, 6 Mar 2014 18:43:03 +0000 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
>
> can I ask you please to include the following branch into linux-next:
> 
> git://linux-arm.org/linux-2.6-lp.git arm-kvm-cpuresume
> 
> It contains a patch touching ARM PM core code that requires wider testing
> coverage before I request a pull. It has been already publicly posted,
> reviewed and tested.

Added from today.  Please make sure you tell me when it is no longer needed.

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

Legal Stuff:
By participating in linux-next, your subsystem tree contributions are
public and will be included in the linux-next trees.  You may be sent
e-mail messages indicating errors or other issues when the
patches/commits from your subsystem tree are merged and tested in
linux-next.  These messages may also be cross-posted to the linux-next
mailing list, the linux-kernel mailing list, etc.  The linux-next tree
project and IBM (my employer) make no warranties regarding the linux-next
project, the testing procedures, the results, the e-mails, etc.  If you
don't agree to these ground rules, let me know and I'll remove your tree
from participation in linux-next.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140307/f1c11ddb/attachment.sig>

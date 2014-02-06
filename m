From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 7 Feb 2014 09:25:05 +1100
Subject: [GIT PULL] tree-wide: clean up no longer required #include
 <linux/init.h>
In-Reply-To: <1391547118-21967-1-git-send-email-paul.gortmaker@windriver.com>
References: <1391547118-21967-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <20140207092505.4c42d130faff151659a908f9@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tue, 4 Feb 2014 15:51:58 -0500 Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
>
> We've had this in linux-next for 2+ weeks (thanks Stephen!) as a
> linux-stable like queue of patches, and as can be seen here:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/paulg/init.git
> 
> most of the changes in the last week have been trivial adding acks
> or dropping patches that maintainers decided to take themselves.

Any thoughts on merging this?  I can feel it bitrotting :-(

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140207/8a3b21f9/attachment.sig>

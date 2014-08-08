From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 8 Aug 2014 14:29:12 +1000
Subject: Request to include Mailbox tree in linux-next
In-Reply-To: <CAJe_ZhdZTSs+Ns4u7bMXwbLHYTnE-5XEE8uev4zXbXrCP52bSg@mail.gmail.com>
References: <CAJe_ZhdZTSs+Ns4u7bMXwbLHYTnE-5XEE8uev4zXbXrCP52bSg@mail.gmail.com>
Message-ID: <20140808142912.7bf68229@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

On Wed, 6 Aug 2014 12:25:49 +0530 Jassi Brar <jaswinder.singh@linaro.org> wrote:
>
>  The framework for Mailbox has undergone 10 revisions over the last
> one year, which has garnered support in the form of 'Reviewed-by' and
> 'looks good enough to be merged in this window' from people in the CC
> list.
> 
>   Could you please add it to linux-next?
> Tree:       git://git.linaro.org/landing-teams/working/fujitsu/integration.git
> Branch:   mailbox-for-3.17
> Contact:  Jassi Brar <jaswinder.singh@linaro.org>

This is really late for v3.17.  The purpose of linux-next is to
discover interactions between trees before they are pulled into Linus'
tree and to do some cross architecture build checking.  Adding a tree
during the merge window is not very helpful to that.

However if this is really going to be merged by Linus before v3.17-rc1,
I will add it on Monday, OK?

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140808/d5e92858/attachment.sig>

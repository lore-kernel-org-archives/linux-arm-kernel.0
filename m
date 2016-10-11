From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 11 Oct 2016 23:41:40 +0200
Subject: latest version of bluetooth for n950?
In-Reply-To: <20161011145140.cq3jex2r23wuayph@earth>
References: <20161011074704.GA21003@amd>
 <20161011145140.cq3jex2r23wuayph@earth>
Message-ID: <20161011214139.cgxe2ms7qjgruuxb@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 11, 2016 at 04:51:40PM +0200, Sebastian Reichel wrote:
> On Tue, Oct 11, 2016 at 09:47:04AM +0200, Pavel Machek wrote:
> > I got some free cycles to play with n900 and bluetooth. There's still
> > some unrelated config option that breaks even the old vesion of
> > patches, but I'm ready for more debugging now.
> > 
> > Could I have the latest version of the (clean) bluetooth patch? I have
> > feeling it might work with the right config option, and would like to
> > try.
> > 
> > For the record, here's working .config and the tricky tricky oneliner
> > that took me week to figure out.
> 
> https://git.kernel.org/cgit/linux/kernel/git/sre/linux-n900.git/log/?h=n950-bluetooth
> 
> My local branch is based on 4.8 and fixes a few of Marcel's
> comments. I'm currently at ELCE, but I will push my local
> stuff later in the hotel after verifying, that it works as
> expected (luckily I brought N950 with me :)).

It does not. Rebasing the pushed branch to v4.8 works, so the
problem is somewhere in my new changes. I will try to have a
look at it tomorrow.

The changes shouldn't affect you for any tests, though. Just
take the branch from above (and optionally rebase to v4.8).

-- Sebastian


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161011/59a1c8ba/attachment.sig>

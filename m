From: simon.guinot@sequanux.org (Simon Guinot)
Date: Thu, 21 Mar 2013 11:59:05 +0100
Subject: [PATCH v3 0/9] refactoring for mask_cache
In-Reply-To: <5149F48D.3030706@keymile.com>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com>
 <1363615255-18200-1-git-send-email-gerlando.falauto@keymile.com>
 <20130319100352.GB2419@localhost>
 <20130319110620.GO13280@titan.lakedaemon.net>
 <51484793.5020102@keymile.com>
 <20130319114430.GP13280@titan.lakedaemon.net>
 <20130319115615.GR13280@titan.lakedaemon.net>
 <5149F48D.3030706@keymile.com>
Message-ID: <20130321105900.GC16903@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 06:40:29PM +0100, Gerlando Falauto wrote:
> Hi,
> 
> sorry about the delay (been busy with other stuff).
> First of all thanks for your hints. I have some questions.
> This is my first time, so please be gentle... :-)
> 
> On 03/19/2013 12:56 PM, Jason Cooper wrote:
> >On Tue, Mar 19, 2013 at 07:44:31AM -0400, Jason Cooper wrote:
> >>Those commit IDs are going to change once LinusW (I presume) applies
> >>them to his tree, so he'll have to edit each commit message to point the
> >>the correct commit.
> >>
> >>LinusW, do you want me to handle this?
> >
> >Never mind, coffee underflow to /dev/brain.  One drawback to mutt, can't
> >view thread while typing messages...
> 
> 1) I had no idea who LinusW is, I assume Linus Walleij who should be
> the maintainer of linux-gpio. And linux-gpio should have nothing to
> do with this discussion... so I should assume you never mentioned
> him, right?
> 
> 2) About the SOB part... most of this is inspired by Simon's
> original (single) patch and Holger's reworking. Should they be given
> credit or not? If yes, how? If I don't get an answer I would just
> assume no and I'll take all the blame and credit all by myself. :-)

Please drop all the SOBs with my name. Except for giving up a patch
almost two years, I am not involved in this patch series development. 
I am quite sure there is no credit in that :)

Thanks.

Simon

> 
> 3) Jason, did you mean you would pull it to
> http://git.infradead.org/users/jcooper/linux.git? Shall I change the
> SOB lines and resubmit? Or should I submit it somewhere else
> instead?
> 
> 4) About submitting to -stable, I guess it wouldn't make any sense
> until it gets included upstream
> (https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/ so
> to speak). Is that right?
> Or at least to jcooper's tree, through which it should eventually
> make it mainline through a merge (therefore keeping its commit-id).
> That right?
> 
> I did read Documentation/stable_kernel_rules.txt and what I
> understand is that it would be enough to submit to
> stable at vger.kernel.org only the last one, while providing a list of
> 
>  Cc: <stable@vger.kernel.org> # 3.0.x: 123456 first patch
>  Cc: <stable@vger.kernel.org> # 3.0.x: 123457 second patch
>  Cc: <stable@vger.kernel.org> # 3.0.x: 123458 third patch
> 
> using the mainstream (or jcooper's) commit IDs.
> 
> I don't know whether I'd have to repeat that for each version (3.0
> will include only a subset of this series, while 3.7 and following
> will need the whole nine yards, and what's in between... well,
> something in between).
> 
> Please let me know what to do. Again, it's my first time so please
> be gentle. :-)
> 
> Thanks again!
> Gerlando
> 
> >>If you prefer to take it:
> >>
> >>Acked-by: Jason Cooper <jason@lakedaemon.net>
> >
> >for the plat-orion/gpio.c bits and if it helps, the gpio-mvebu.c bits.
> >
> >thx,
> >
> >Jason.
> >
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130321/736911a4/attachment.sig>

From: linux4michelle@tamay-dogan.net (Michelle Konzack)
Date: Wed, 26 Aug 2009 12:32:25 +0200
Subject: ARM Git Tree (at91sam9g45 patches)
In-Reply-To: <4A95043C.9040807@atmel.com>
References: <9f53b4330908251727q1bc1accfk12a9a8d25407791@mail.gmail.com>
	<4A9488FB.60603@eukrea.com> <4A94FDDD.205@atmel.com>
	<4A95043C.9040807@atmel.com>
Message-ID: <20090826103225.GB29500@tamay-dogan.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

I have recently bought from DigiKey the AT91SAM9G45 Evaluation  Kit  and
would like to sa thanks for the Patch...

I have the hell here to get it running...

Note:  My own codes stuff (not running Linux) is working perfectly.
       (I am coding mostly in ASM)

Thanks, Greetings and nice Day/Evening
    Michelle Konzack
    Electronic Engineer
    Tamay Dogan Network
    Debian GNU/Linux Consultant


Am 2009-08-26 11:45:32, schrieb Nicolas Ferre:
> Hi all,
> 
> I respond to myself...
> 
> Nicolas Ferre :
> > Eric B?nard :
> >> Hi Robert,
> >>
> >> Robert Emanuele wrote :
> >>> I'm working with the Atmel at91sam9g45-ekes board which is new.  I was
> >>> wondering if there was a git tree with the current ARM patches that
> >>> contains the at91sam9g45 code?  Russell lists "Applied" patches at
> >>> http://www.arm.linux.org.uk/developer/patches/ .  Where are these
> >>> applied to?  If there isn't a tree, is there an elegant way to get the
> >>> latest patch sets that I could apply to Linus's tree?
> >>>
> >> you will find the files that you can apply using git am here :
> >> ftp://ftp.arm.linux.org.uk/pub/armlinux/kernel/git-cur/
> > 
> > Yes, devel branch contains 9g45 patches.
> > 
> > Another place where you can find quite all drivers that I submitted
> > during the past weeks is in the linux-next tree:
> > 
> > http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=summary
> > 
> > FYI, I am building a patchset collecting all those submitted patches
> > against 2.6.30 + Andrew Victor -at91 patch.
> > It is not finished at the moment but I can send it in private.
> 
> In fact I baked an archive that stores a snapshot of my work:
> ftp://www.linux4sam.org/devel/linux/2630_lnx4sam_patchset-tmp_20090826.tgz
> 
> It is against vanilla 2.6.30
> + -at91 patch (from: http://maxim.org.za/at91_26.html of course)
> 
> Regards,
> -- 
> Nicolas Ferre
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
------------------------ END OF REPLIED MESSAGE ------------------------




-- 
Linux-User #280138 with the Linux Counter, http://counter.li.org/
##################### Debian GNU/Linux Consultant #####################
<http://www.tamay-dogan.net/>                 Michelle Konzack
<http://www.can4linux.org/>                   Apt. 917
<http://www.flexray4linux.org/>               50, rue de Soultz
Jabber linux4michelle at jabber.ccc.de           67100 Strabourg/France
IRC    #Debian (irc.icq.com)                  Tel. DE: +49 177 9351947
ICQ    #328449886                             Tel. FR: +33  6  61925193
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090826/6315826c/attachment.sig>

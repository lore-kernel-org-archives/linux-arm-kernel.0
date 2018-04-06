From: jhogan@kernel.org (James Hogan)
Date: Fri, 6 Apr 2018 22:26:01 +0100
Subject: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
In-Reply-To: <b748fdcb-e09f-9fe3-dc74-30b6a7d40cbe@codeaurora.org>
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
 <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
 <41e184ae-689e-93c9-7b15-0c68bd624130@codeaurora.org>
 <b748fdcb-e09f-9fe3-dc74-30b6a7d40cbe@codeaurora.org>
Message-ID: <20180406212601.GA1730@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 06, 2018 at 02:15:57PM -0400, Sinan Kaya wrote:
> On 4/5/2018 9:34 PM, Sinan Kaya wrote:
> > Can we get these merged to 4.17? 
> > 
> > There was a consensus to fix the architectures having API violation issues.
> > https://www.mail-archive.com/netdev at vger.kernel.org/msg225971.html
> > 
> > 
> 
> Any news on the MIPS front? Is this something that Arnd can merge? or does it have
> to go through the MIPS tree.

It needs some MIPS input really. I'll try and take a look soon. Thanks
for the nudge.

> It feels like the MIPS is dead since nobody replied to me in the last few weeks on
> a very important topic.

Not dead, just both maintainers heavily distracted by real life right
now (which sadly, for me at least, trumps this very important topic) and
doing the best they can given the circumstances.

Cheers
James
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180406/50aa7ed9/attachment.sig>

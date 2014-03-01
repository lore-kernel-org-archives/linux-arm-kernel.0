From: broonie@kernel.org (Mark Brown)
Date: Sat, 1 Mar 2014 12:53:39 +0900
Subject: [PATCH 14/28] Remove MACH_SMDKC210
In-Reply-To: <1393623789.4052.17.camel@x220>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
 <1391971686-9517-15-git-send-email-richard@nod.at>
 <20140210114154.GQ1757@sirena.org.uk>
 <1392039072.3585.15.camel@x220>
 <20140210141255.GI1757@sirena.org.uk>
 <1392046242.3585.41.camel@x220>
 <20140210163621.GA13533@sirena.org.uk>
 <1392070159.27939.34.camel@x220>
 <20140212160431.GB28112@sirena.org.uk>
 <1393623789.4052.17.camel@x220>
Message-ID: <20140301035339.GK29849@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 10:43:09PM +0100, Paul Bolle wrote:

> That commit is fine with me, of course. I now see no reason to continue
> my, rather slowly progressing, search for the problem that you wanted to
> get properly fixed. I suppose another commit already fixed it.

No, but it's someone from Samsung (Sachin works with the Samsung landing
team at Linaro) not caring about those drivers on these boards any more
and mentioning the DT conversion which is rather different to someone
doing mechanical cleanup with no mention of where the symbols went.

It should be fairly obvious that if the reason symbols are being removed
due to DT conversion of the platforms then the default thing should be
that the drivers be being converted to DT and appropriate DT entries
being added to the board DTS files, but more generally the important
thing is that some understanding is shown as to why the symbols vanished
and why the mechanical fix suggested is OK.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140301/eb650b52/attachment.sig>

From: contact@paulk.fr (Paul Kocialkowski)
Date: Thu, 16 Apr 2015 11:10:21 +0200
Subject: [PATCH 1/2] Documentation: devicetree: root node serial-number
 property documentation
In-Reply-To: <f6f4f862c78fa626e7f94bde51eec5b1@agner.ch>
References: <1427564371-26039-1-git-send-email-contact@paulk.fr>
 <f6f4f862c78fa626e7f94bde51eec5b1@agner.ch>
Message-ID: <1429175421.2483.1.camel@collins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le jeudi 16 avril 2015 ? 09:56 +0200, Stefan Agner a ?crit :
> On 2015-03-28 18:39, Paul Kocialkowski wrote:
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> 
> I think this is a worthwhile standardization.
> 
> Acked-by: Stefan Agner <stefan@agner.ch>

Thanks! I should also add a commit message in v2 mentioning that this is
already used in open firmware and reported by lshw.

> > ---
> >  Documentation/devicetree/booting-without-of.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/booting-without-of.txt
> > b/Documentation/devicetree/booting-without-of.txt
> > index 7768518..8b055897 100644
> > --- a/Documentation/devicetree/booting-without-of.txt
> > +++ b/Documentation/devicetree/booting-without-of.txt
> > @@ -828,6 +828,10 @@ address which can extend beyond that limit.
> >    name may clash with standard defined ones, you prefix them with your
> >    vendor name and a comma.
> >  
> > +  Additional properties for the root node:
> > +
> > +    - serial-number : a string representing the board's serial number
> > +
> >    b) The /cpus node
> >  
> >    This node is the parent of all individual CPU nodes. It doesn't
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150416/02095292/attachment.sig>

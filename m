From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 23 Apr 2014 11:40:18 +0200
Subject: [PATCH v8 00/17] ARM: sunxi: Add driver for SD/MMC hosts found
 on Allwinner sunxi SoCs
In-Reply-To: <53565DDA.9020202@redhat.com>
References: <1398164497-14212-1-git-send-email-hdegoede@redhat.com>
 <53565B74.4000703@elopez.com.ar> <53565DDA.9020202@redhat.com>
Message-ID: <20140423094018.GJ24905@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 02:17:30PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 04/22/2014 02:07 PM, Emilio L?pez wrote:
> > Hi Hans,
> > 
> > El 22/04/14 08:01, Hans de Goede escribi?:
> >> Hi All,
> >>
> >> Here is v8 of the sunxi-mmc patch-set David Lanzend?rfer and I have been
> >> working on.
> >>
> >> The first 2 patches are depenencies which should go in through the clk tree,
> >> Mike can you pick these 2 up please ?  :
> >>
> >> "clk: sunxi: factors: automatic reparenting support"
> >> Is uncontroversial and has been favorably reviewed by various people.
> > 
> > I'll pick this one up for 3.16 if you're ok with that. Mike, let
> > me know if you have any objection to the patch, but I'm pretty
> > sure you (informally?) acked it in the past.
> > 
> >> "clk: sunxi: Implement MMC phase control"
> >> Is somewhat more controversial as there has been lots of discussion about
> >> adding a generic phase control method to the clk framework. The problem is
> >> that there has been a lot of talk about such a generic phase control method
> >> but not a single patch. Therefor I would like to move forwards with using
> >> a platform specific method for now. I hereby promise that once we've a generic
> >> method I'll write patches to convert the sunxi code to that method.
> > 
> > Mike proposed a RFC for handling this better, and there were talks
> > with Allwinner people to see what did these phase controls
> > actually mean. We should be able to get a proper solution for it
> > during this cycle. I'd prefer to work towards that instead of
> > merging this, as we have more than a month to get it ready still.
> 
> A month will be gone before you know it, and merging sunxi mmc support really
> is long overdue, and is the last thing keeping distros from shipping with sunxi
> support ootb. So I would really prefer to just get this merged as is for now,
> changing it later should be easy, and merging an interim solution will make
> some more time for doing the generic clk phase control method properly.

While I'd be inclined to agree, it will be up to Mike.

Mike?

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140423/56d549db/attachment.sig>

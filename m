From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 5 Feb 2014 11:19:18 -0300
Subject: [RFC PATCH v2 03/14] of: mtd: add documentation for
 nand-ecc-level property
In-Reply-To: <52F23DF4.7010901@gmail.com>
References: <1391006064-28890-1-git-send-email-b.brezillon.dev@gmail.com>
 <1391006064-28890-4-git-send-email-b.brezillon.dev@gmail.com>
 <20140129175331.GA27143@localhost>
 <20140205111500.B19FDC40A89@trevor.secretlab.ca>
 <52F23DF4.7010901@gmail.com>
Message-ID: <20140205141917.GA25091@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant, Boris:

(BTW, dropped Russell, Rob Landley and some unrelated mailing lists from Cc,
and added Thomas, Gregory and Rob Herring).

On Wed, Feb 05, 2014 at 02:34:44PM +0100, Boris BREZILLON wrote:
> On 05/02/2014 12:15, Grant Likely wrote:
> > On Wed, 29 Jan 2014 14:53:32 -0300, Ezequiel Garcia <ezequiel.garcia@free-electrons.com> wrote:
[..]
> >>
> >> Maybe we can discuss about it now?
> >>
> >>    nand-ecc-strength : integer ECC required strength.
> >>    nand-ecc-size : integer step size associated to the ECC strength.
> > I'm okay with either, but the above binding is indeed more readable.
> 
> That's fine by me, if everybody agrees, let's go for the
> nand-ecc-strength/nand-ecc-size couple then.
> 

Great. So, if some DT dictator^C^Cmaintainers can Ack this binding,
I can send a new patchset, with pxa3xx-nand using it...

> I'll rebase next version of my series on Ezequiel's patch providing
> these OF helpers.
> 

... and then you can base on it?

This is the original patchset:

http://permalink.gmane.org/gmane.linux.drivers.devicetree/58764
http://permalink.gmane.org/gmane.linux.drivers.devicetree/58763

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com

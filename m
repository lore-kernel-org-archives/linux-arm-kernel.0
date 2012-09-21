From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 21 Sep 2012 13:30:53 +1000
Subject: [PATCH v2 2/2] PCI: Provide a default pcibios_update_irq()
In-Reply-To: <CAErSpo4RgNjFE7zH9vKTgAq_7djbWi5sR7k_DJYr8=G3A=0zeg@mail.gmail.com>
References: <1347880974-13615-1-git-send-email-thierry.reding@avionic-design.de>
 <1347880974-13615-2-git-send-email-thierry.reding@avionic-design.de>
 <20120920083731.b99255eb8fdeea908d34ed2f@canb.auug.org.au>
 <CAErSpo4RgNjFE7zH9vKTgAq_7djbWi5sR7k_DJYr8=G3A=0zeg@mail.gmail.com>
Message-ID: <20120921133053.7d92b41c54d3400e952ee8ff@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On Thu, 20 Sep 2012 21:19:30 -0600 Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> On Wed, Sep 19, 2012 at 4:37 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Didn't we have a problem with some compiler versions when the weak
> > definition was in the same file as the call (there is a call to this
> > function in drivers/pci/setup-irq.c)?
> 
> There was such a bug, but as far as I know, we aren't worrying about
> it anymore: https://lkml.org/lkml/2011/7/4/9

OK, thanks.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120921/809a08c6/attachment.sig>

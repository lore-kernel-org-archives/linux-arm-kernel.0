From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 5 Nov 2013 13:28:43 -0700
Subject: [PATCH v6 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
In-Reply-To: <52792C5E.6030008@writeme.com>
References: <1379319655-20210-1-git-send-email-xobs@kosagi.com>
 <1379319655-20210-4-git-send-email-xobs@kosagi.com>
 <CAJ+vNU36neHP77dVnqSP=+oMxaU=-6PxWQ8Afni-tTRjNTkM_A@mail.gmail.com>
 <0E83723C55F66F43A6041464FE31119D40FC99@039-SN2MPN1-011.039d.mgd.msft.net>
 <CAJ+vNU13FA5s7tt-yEnBYNSBV+FHmHqZNoykFq8aF=O=TvqTnA@mail.gmail.com>
 <0E83723C55F66F43A6041464FE31119D40FD55@039-SN2MPN1-011.039d.mgd.msft.net>
 <CAJ+vNU2ifxfprYsgcQs+Kkgu37+diXHJS6DEqs4d51+U3F4sLQ@mail.gmail.com>
 <52792C5E.6030008@writeme.com>
Message-ID: <CAErSpo7c1KiOKqpM1+v6GM09Mspge=Yq9orwXVYjZZjsQssCHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 5, 2013 at 10:35 AM, Sinan Akman <sinan@writeme.com> wrote:
>   Tim, Sean what is the status of this patch ? Is it part of any tree
> already ? I'd like to test few things.

This patch is in my "next" branch and will be merged into Linus' tree
during the v3.13 merge window (probably next week).  It's also in the
linux-next tree.

http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=next&id=bb38919ec56e0758c3ae56dfc091dcde1391353e

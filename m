From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 13 Aug 2013 11:19:10 -0600
Subject: [PATCH v2 0/5] ARM: dove: DT PCIe support
In-Reply-To: <20130813140130.GA25111@titan.lakedaemon.net>
References: <1376396724-32048-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130813140130.GA25111@titan.lakedaemon.net>
Message-ID: <CAErSpo7DnfQBzoSX+rh6A0QrPO3Z3cjD=8ajZiFwKH0MBTG4og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 13, 2013 at 8:01 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> Bjorn,
>
> On Tue, Aug 13, 2013 at 02:25:19PM +0200, Sebastian Hesselbarth wrote:
>> This patch set adds support for the PCIe controllers found on Marvell
>> Dove SoCs. It depends on mvebu-pci patches sent by Thomas Petazzoni.
>
> Well, when it rains, it pours.  If this series looks good to you, I'll
> go ahead and add it on top of Thomas' patches.

Yep, that's fine with me.  I consider the stuff in drivers/pci/host/
as basically arch code that is collected as a convenience for code
sharing.  I can't test it, and I can only evaluate it as far as
looking for the most obvious things related to use of core PCI
interfaces.

Bjorn

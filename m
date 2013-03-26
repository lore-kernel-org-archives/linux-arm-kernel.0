From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 26 Mar 2013 22:12:34 +0100
Subject: [PATCHv6 10/17] arm: mvebu: add PCIe Device Tree informations
 for Armada 370
In-Reply-To: <201303262050.12847.arnd@arndb.de>
References: <1364314719-1049-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130326163421.GA30255@obsidianresearch.com>
 <20130326201654.GA7109@avionic-0098.mockup.avionic-design.de>
 <201303262050.12847.arnd@arndb.de>
Message-ID: <20130326211234.GA1295@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 26, 2013 at 08:50:12PM +0000, Arnd Bergmann wrote:
> On Tuesday 26 March 2013, Thierry Reding wrote:
> >                 pci at 1,0 {
> >                         device_type = "pci";
> >                         assigned-addresses = <0x82000800 0 0x80000000 0 0x1000>;
> >                         reg = <0x000800 0 0 0 0>;
> >                         status = "disabled";
> > 
> >                         #address-cells = <3>;
> >                         #size-cells = <2>;
> > 
> >                         nvidia,num-lanes = <2>;
> >                 };
> 
> Shouldn't there be an empty ranges property in there as well?

Technically yes, I think. Though it doesn't make a bit of a difference
on Linux.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130326/a0a1768d/attachment.sig>

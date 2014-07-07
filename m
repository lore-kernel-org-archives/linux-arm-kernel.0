From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 08 Jul 2014 01:21:50 +0400
Subject: [PATCH v4 0/3] Add R8A7791/Koelsch/Henninger board PCI DT support
In-Reply-To: <9076479.78BOG4SjZ9@wuerfel>
References: <201406242207.32790.sergei.shtylyov@cogentembedded.com>
 <9076479.78BOG4SjZ9@wuerfel>
Message-ID: <53BB0F6E.5080600@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 06/24/2014 10:22 PM, Arnd Bergmann wrote:

>>     Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
>> 'renesas-devel-v3.16-rc2-20140623' tag. Here we add PCI USB device tree support
>> for the R8A7791-based Koelsch and Henninger boards. As the 'pci-rcar-gen2'
>> driver device tree support has been merged for 3.16, this patchset can now be
>> merged too...

>> [1/3] ARM: shmobile: r8a7791: add internal PCI bridge nodes
>> [2/3] ARM: shmobile: koelsch: enable internal PCI
>> [3/3] ARM: shmobile: henninger: enable internal PCI

> Acked-by: Arnd Bergmann <arnd@arndb.de>

    Simon, what's up with this series? You've merged analogous series for 
R8A7790 but not this one. You followed up to an older version of it, asking me 
to re-post when the driver patch gets merged but it already had been merged 
already (and this version posted), and I got no reply from you then...

WBR, Sergei

From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 22 Sep 2014 16:12:54 -0600
Subject: [PATCH 3/5] ARM: mvebu: armada-xp: Correct misnumbered PCIe port
 nodes
In-Reply-To: <541E11BB.7070202@gmail.com>
References: <1411236391-422-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1411236391-422-4-git-send-email-sebastian.hesselbarth@gmail.com>
 <541E11BB.7070202@gmail.com>
Message-ID: <CAErSpo7EX-jndHSvzjmpHs+hNiBieMGX58tCz2C8Ce9WJjQ_ZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 20, 2014 at 5:46 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:
> On 09/20/2014 08:06 PM, Sebastian Hesselbarth wrote:
>> Currently, Armada XP PCIe nodes are numbered pcie@<N>,0 with N just
>> incrementing. To reflect port/lane relationship, rename the nodes
>> to pcie@<port>,<lane>. While at it, add node aliases to each of pcie
>> controller and port nodes and get rid of now redundant port/lane
>> comments.
>>
>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> ---
>
> After thinking a while about the current numbering scheme, I have to
> admit that it is correct. The @numbers represent assigned-address of
> the pcie port and this what it is right now.
>
> If there are no more comments, I'll resend the series without messing
> with the numbering scheme.

If your intention is that these go through my PCI tree, please cc:
linux-pci at vger.kernel.org, because I only look at the linux-pci
patchwork for things to merge.

Bjorn

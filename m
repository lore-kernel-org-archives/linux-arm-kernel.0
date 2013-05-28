From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 28 May 2013 22:01:19 +0200
Subject: [PATCH 00/10] clk: mvebu: restructure SoC clock drivers
In-Reply-To: <20130528165401.GX31290@titan.lakedaemon.net>
References: <1368234490-31416-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130528154047.GT31290@titan.lakedaemon.net> <20130528175343.77c6353d@skate>
 <20130528165401.GX31290@titan.lakedaemon.net>
Message-ID: <51A50D0F.5010909@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2013 06:54 PM, Jason Cooper wrote:
>> On Tue, 28 May 2013 11:40:47 -0400, Jason Cooper wrote:
>>> I'm posting the revised version as replies to patches 1, 5 and 6. Please
>>> let me know if I messed it up.  I'd like to send the PR for these
>>> shortly.
>
> $ git checkout v3.10-rc3
> $ git merge mvebu/of_pci
> $ git merge mvebu/pcie
> $ git merge mvebu/seb_clk

After manually resolving a merge conflict in arch/arm/mach-mvebu/Kconfig
I can see no obvious regression on neither Dove nor Kirkwood.

Sebastian

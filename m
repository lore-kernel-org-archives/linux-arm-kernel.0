From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 26 Nov 2012 10:28:05 +0100
Subject: [GIT PULL 5/5] ARM: mvebu: changes for v3.8
In-Reply-To: <20121126091652.GA13866@quad.lixom.net>
References: <pull-1353733874-990435>
 <50b056f7.8687e50a.170d.7c22SMTPIN_ADDED_MISSING@mx.google.com>
 <20121126091652.GA13866@quad.lixom.net>
Message-ID: <20121126102805.5337f7f5@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

On Mon, 26 Nov 2012 01:16:52 -0800, Olof Johansson wrote:
> > Jason Cooper (14):
> >       Merge tag 'marvell-mvebu-clk-3.8' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
> >       Merge tag 'marvell-sata-3.8' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
> >       Merge tag 'marvell-neta-for-3.8' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
> >       Merge tag 'marvell-boards-net-for-3.8' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
> >       Merge tag 'marvell-net-mdio-checkpatch-fixes-3.8' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
> >       Merge tag 'marvell-mvneta-fix-and-clk-support-3.8' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
> >       Merge tag 'marvell-neta-dt-clk-updates-3.8' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
> >       Merge tag 'marvell-xor-cleanup-dt-binding-3.8' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
> >       Merge tag 'marvell-xor-board-dt-changes-3.8-v2' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
> >       Merge tag 'marvell-net-xor-defconfig-for-3.8' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
> >       Merge tag 'marvell-armadaxp-smp-for-3.8' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
> >       Merge tag 'marvell-hwiocc-for-3.8' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
> >       Merge tag 'marvell-openblocks-i2c-sata-for-3.8' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
> >       Merge branch 'mvebu-misc-fixes' of git://github.com/MISL-EBU-System-SW/mainline-public into mvebu/everything
> 
> Based on these merge commits, it looks like they organized things pretty well.
> With this amount of code, if you want to mostly expose this to us coming
> up to our level, that's fine.
> 
> Looking at the actual tree (in gitk to get visalization), it looks like
> things held up well until the "test-the-merge" mergepoint which had some
> patches on top of it instead of in a separate branch, I think? Those
> merges are these:

Right. The problem is that some of the last developments had many
dependencies against the previous developments, from various branches.
So I wasn't sure how to do this last developments, and I did merge the
branches containing the previous developments that I needed.

I am really open to suggestions on how to improve my Git workflow to
handle this better. It certainly wasn't my intention to have this
"test-the-merge" thing appear publicly.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

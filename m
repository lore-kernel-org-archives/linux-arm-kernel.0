From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 17 Nov 2009 00:38:53 +0800
Subject: [PATCH 0/2] Support for the Arcom Zeus SBC, #2
In-Reply-To: <20091114182925.17eb58ea@taxman.wild-wind.fr.eu.org>
References: <20091114182925.17eb58ea@taxman.wild-wind.fr.eu.org>
Message-ID: <f17812d70911160838s91f3b74w4cac9e78edb9fa46@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 15, 2009 at 1:29 AM, Marc Zyngier <maz@misterjones.org> wrote:
> The Arcom Zeus is a pxa270 board with a PC104 bus, vaguely similar to
> the Arcom Viper. The following patches adds support for most of the
> on-board devices (though sound and CAN are still missing).
>
> Patches are against PXA devel branch. Please note that they depend on
> the following patch, currently queued in Eric's fix branch:
> http://git.kernel.org/?p=linux/kernel/git/ycmiao/pxa-linux-2.6.git;a=commit;h=b2b36316626f0d6b92c3675a2aa2726efc71d146
>
> The defconfig patch has been already posted before, and can be found in
> the archives at the following address:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2009-November/004014.html
>
> This work started from Arcom's 2.6.16, but all bugs are of course mine.

Marc,

What's the difference of this #2 from #1 you posted earlier?

>
> ? ? ? ?M.
> --
> I'm the slime oozin' out from your TV set...
>

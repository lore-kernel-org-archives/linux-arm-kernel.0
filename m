From: eric.miao@linaro.org (Eric Miao)
Date: Tue, 30 Aug 2011 14:35:27 +0800
Subject: [PATCH V6 2/5] ahci_plt Add the board_ids and pi refer to
	different features
In-Reply-To: <CAJNCFVJKvO+W0ogn-3GOsR8ygtn5KWtqTc2sw6HuNB2-x7ZviA@mail.gmail.com>
References: <1314602339-18392-1-git-send-email-richard.zhu@linaro.org>
	<1314602339-18392-2-git-send-email-richard.zhu@linaro.org>
	<20110829121214.GA15484@oksana.dev.rtsoft.ru>
	<CAMPhdO_XsrGTiiKpALVU7tZiAO_C5d_9XKoVjL_BHwpcqzXcFg@mail.gmail.com>
	<CAJNCFVJKvO+W0ogn-3GOsR8ygtn5KWtqTc2sw6HuNB2-x7ZviA@mail.gmail.com>
Message-ID: <CAMPhdO-c48EG4JzX+bY-1C57e+MU7wzeC-tGQA10fiq=nW-fMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2011 at 2:21 PM, Richard Zhu <richard.zhu@linaro.org> wrote:
> Hi:
> Pass port info from the platform data is a good idea.
> About the codes duplication in the board level, I think that we can
> re-use the default ?port info on most boards, when the ata_port_info
> is null in the platform data struct.
> We can leave the ahci_platform.c without any modifications in this way.
>
> How do you guys think about?

+1. Richard, please let's first go that way, so to have minimum impact to
ahci_platform.c

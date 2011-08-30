From: eric.miao@linaro.org (Eric Miao)
Date: Tue, 30 Aug 2011 17:07:28 +0800
Subject: [PATCH V6 2/5] ahci_plt Add the board_ids and pi refer to
	different features
In-Reply-To: <CAJNCFVKPUW95F0Wt9eVWs0+ne1pdXreYi6uSKH2TkR+Qt_sm4A@mail.gmail.com>
References: <1314602339-18392-1-git-send-email-richard.zhu@linaro.org>
	<1314602339-18392-2-git-send-email-richard.zhu@linaro.org>
	<20110829121214.GA15484@oksana.dev.rtsoft.ru>
	<CAMPhdO_XsrGTiiKpALVU7tZiAO_C5d_9XKoVjL_BHwpcqzXcFg@mail.gmail.com>
	<CAJNCFVJKvO+W0ogn-3GOsR8ygtn5KWtqTc2sw6HuNB2-x7ZviA@mail.gmail.com>
	<CAJNCFVKPUW95F0Wt9eVWs0+ne1pdXreYi6uSKH2TkR+Qt_sm4A@mail.gmail.com>
Message-ID: <CAMPhdO9ndyAq57ptBKXo1owWLatJaTeOXvEvzoxcfh19h=piBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2011 at 3:07 PM, Richard Zhu <richard.zhu@linaro.org> wrote:
> Hi:
> One more concern, the .../drivers/ata/ahci.h file should be moved to
> .../include/linux/ folder.
> Because that the kinds of macros used in the ata_port_info and the
> ahci_pmp_retry_srst_ops are
> all defined in the .../drivers/ata/ahci.h file.
> Otherwise, the ata_port_info can't be defined in the board related
> platform data.
>
> How we can handle this case?

That's indeed an issue, Anton, what's your suggestion?

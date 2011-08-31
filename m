From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 31 Aug 2011 08:55:10 +0200
Subject: [PATCH V7 0/5] imx53 ahci driver v7
In-Reply-To: <1314762635-3923-1-git-send-email-richard.zhu@linaro.org>
	(Richard Zhu's message of "Wed, 31 Aug 2011 11:50:30 +0800")
References: <1314762635-3923-1-git-send-email-richard.zhu@linaro.org>
Message-ID: <87obz683zl.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Richard Zhu <richard.zhu@linaro.org> writes:

Hi,

> *** BLURB HERE ***
> This is the seventh iteration of the imx53 ahci patch. Changes between
> v5 and v7 are described in the following description.
>
> ChangeLog v5->v6:
>  - Move the most ahci initialization codes from the board related files
>  to the common ahci_sata file.
>
>  - Add the imx53 ahci's own ata_port_info definition in ahci_platform
>  driver, since the 'ahci_pmp_retry_srst_ops' is required when imx53
>  ahci is present.
>
> ChangeLog v6->v7:
>  - Define the default imx53 ahci platform data, reduce the modificatons
>  on the board related files.
>
>  - Handle the sata_pwr_en pin obviously on smd board.
>
Sorry to disturb you with silly questions, but a v7 has already been
sent yesterday [1]. Is this patchset the same as yesterday or did you
modify some parts ?

Thanks,
Arnaud

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/063195.html

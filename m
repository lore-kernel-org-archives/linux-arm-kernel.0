From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 14 Feb 2018 15:58:31 +0100
Subject: [PATCH 1/2] mmc: bcm2835: reset host on timeout
In-Reply-To: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
Message-ID: <1fbf0d77-cb53-f0fa-b810-e9954138d907@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

Am 14.02.2018 um 15:38 schrieb Michal Suchanek:
> The bcm2835 mmc host tends to lock up for unknown reason so reset it on
> timeout. The upper mmc block layer tries retransimitting with single
> blocks which tends to work out after a long wait.
>
> This is better than giving up and leaving the machine broken for no
> obvious reason.

could you please provide more information about this issue (affected
hardware, kernel config, version, dmesg, reproducible scenario)?

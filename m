From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Sun, 9 Jan 2011 06:02:23 +0300
Subject: [PATCH v4 3/3] ahci_platforms: add support for CNS3xxx SoC devices
In-Reply-To: <1294537775-21714-4-git-send-email-mkl0301@gmail.com>
References: <1294537775-21714-1-git-send-email-mkl0301@gmail.com>
	<1294537775-21714-4-git-send-email-mkl0301@gmail.com>
Message-ID: <20110109030223.GB27507@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 09, 2011 at 09:49:35AM +0800, mkl0301 at gmail.com wrote:
> From: Mac Lin <mkl0301@gmail.com>
> 
> CNS3xxx override the softreset function of ahci_platform ahci_softreset by
> cns3xxx_ahci_softreset, which would retry ahci_do_softreset again with pmp=0 if
> pmp=15 failed, for the controller has problem receiving D2H Reg FIS of the
> different PMP setting of the previous sent H2D Reg FIS.
[...]
> Signed-off-by: Mac Lin <mkl0301@gmail.com>

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com

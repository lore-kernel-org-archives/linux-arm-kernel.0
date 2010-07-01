From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 1 Jul 2010 21:55:47 +0900
Subject: [PATCH 29/33] Removing dead SND_SOC_SMDK2443_WM9710
In-Reply-To: <e5391de6858597bbfd43874aed124a73f74850b5.1277911346.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<e5391de6858597bbfd43874aed124a73f74850b5.1277911346.git.siccegge@cs.fau.de>
Message-ID: <AANLkTinZa7_TEjYFTu9V6obndpVvMmHppaOArM1AJg_t@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 1, 2010 at 1:03 AM, Christoph Egger <siccegge@cs.fau.de> wrote:
> SND_SOC_SMDK2443_WM9710 doesn't exist in Kconfig, therefore removing
> all references for it from the source code.
I'd rather have the code compiled unconditionally.

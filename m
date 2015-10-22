From: leoli@freescale.com (Li Yang)
Date: Thu, 22 Oct 2015 12:38:48 -0500
Subject: [PATCH v4 5/6] PCI: layerscape: add PCIe support for LS1043a and
 LS2080a
In-Reply-To: <20151021213612.GK1583@localhost>
References: <1444979960-24100-1-git-send-email-Minghuan.Lian@freescale.com>
 <1444979960-24100-5-git-send-email-Minghuan.Lian@freescale.com>
 <20151021213612.GK1583@localhost>
Message-ID: <CADRPPNSPP1m_7zNF6wEfw9+Bpe=Z_gUA81cSaV4SENVpR34YWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2015 at 4:36 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Fri, Oct 16, 2015 at 03:19:19PM +0800, Minghuan Lian wrote:
>> Both LS1043a and LS2080a are based on ARMv8 64-bit architecture
>> and have similar PCIe implementation. LUT is added to controller.
>> The patch removes the necessary fields from struct ls_pcie.
>>
>> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
>> ---
>> This patch is based on v4.3-rc4 and [PATCH v10 3/6]
>> PCI: designware: Add ARM64 support.

Hi Bjorn,

Are you also applying this patch
https://patchwork.ozlabs.org/patch/531184/ in this merge windows?
Because the new hardware can only work with the generic ARM64 support
added in the designware pcie driver.

Regards,
Leo

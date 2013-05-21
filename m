From: gang.chen@asianux.com (Chen Gang)
Date: Tue, 21 May 2013 17:26:08 +0800
Subject: [PATCH] arm64: kernel: compiling issue,
 need 'EXPORT_SYMBOL_GPL(read_current_timer)'
In-Reply-To: <519B3738.1010004@arm.com>
References: <5199C725.8050102@asianux.com>
 <168084c28e8ba5124c05553e97463172@localhost>
 <20130520095606.GH31359@mudshark.cambridge.arm.com>
 <519AF2DC.2040200@asianux.com> <5bf8a8dd20ecd01c14f0ed9aa054f2df@localhost>
 <519B332F.1000404@asianux.com> <519B3738.1010004@arm.com>
Message-ID: <519B3DB0.4020806@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/21/2013 04:58 PM, Marc Zyngier wrote:
> I think you should try to implement Will's suggestion and drop
> read_current_timer (and the ARCH_HAS_READ_CURRENT_TIMER macro) altogether.
> 
> It would be a much better fix.

OK, thanks. I will send patch v2.

-- 
Chen Gang

Asianux Corporation

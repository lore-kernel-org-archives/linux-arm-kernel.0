From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 10 Aug 2016 16:41:09 +0100
Subject: [PATCH v6 6/8] arm64, dts: add Juno r2 cpu capacity-dmips-mhz
 information
In-Reply-To: <1468932048-31635-7-git-send-email-juri.lelli@arm.com>
References: <1468932048-31635-1-git-send-email-juri.lelli@arm.com>
 <1468932048-31635-7-git-send-email-juri.lelli@arm.com>
Message-ID: <fedd8373-7cc4-5dc3-3b15-7f4e6129f156@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/07/16 13:40, Juri Lelli wrote:
> Add Juno r2 cpu capacity-dmips-mhz bindings information.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Liviu Dudau <Liviu.Dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

(reluctantly :), though I agree the bindings are approved to allow this,
  it seems odd to see capacity-dmips-mhz = <485> here and <578> on R0
  for the A53 CPUs)

-- 
Regards,
Sudeep

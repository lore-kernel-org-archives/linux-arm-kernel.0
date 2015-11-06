From: yalin.wang2010@gmail.com (yalin wang)
Date: Sat, 7 Nov 2015 00:11:16 +0800
Subject: [PATCH] arm64: add HAVE_LATENCYTOP_SUPPORT config
In-Reply-To: <20151106160501.GR6087@arm.com>
References: <1446825478-24824-1-git-send-email-yalin.wang2010@gmail.com>
 <20151106160501.GR6087@arm.com>
Message-ID: <247F438B-3EEA-4550-970E-A649D0E604ED@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i just enable it on ARM64,
and it can work,
i don?t see some special requirement to enable this config .
> On Nov 7, 2015, at 00:05, Will Deacon <will.deacon@arm.com> wrote:
> 
> On Fri, Nov 06, 2015 at 11:57:58PM +0800, yalin wang wrote:
>> Add HAVE_LATENCYTOP_SUPPORT in Kconfig, so that
>> we can enable this feature on ARM64
> 
> Do you know what the prerequisites for HAVE_LATENCYTOP_SUPPORT actually
> are (beyond those explicitly listed as dependencies for CONFIG_LATENCYTOP)?
> 
> Will

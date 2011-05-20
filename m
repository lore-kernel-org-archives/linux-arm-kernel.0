From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 May 2011 15:32:14 +0100
Subject: [PATCH v3 2/2] arm: Add Cortex A5 proc info
In-Reply-To: <1305898769-10462-2-git-send-email-pawel.moll@arm.com>
References: <1305892312.17656.72.camel@hornet.cambridge.arm.com>	<1305898769-10462-1-git-send-email-pawel.moll@arm.com>
	<1305898769-10462-2-git-send-email-pawel.moll@arm.com>
Message-ID: <002201cc16fa$b6bc2380$24346a80$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This patch adds processor info for ARM Ltd. Cortex A5,
> which has SCU initialisation procedure identical to A9.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  arch/arm/mm/proc-v7.S |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will

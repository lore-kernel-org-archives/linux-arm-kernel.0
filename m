From: jcm@jonmasters.org (Jon Masters)
Date: Sat, 9 Jun 2018 09:03:51 -0400
Subject: [PATCH v2 07/17] arm64: ssbd: Skip apply_ssbd if not using
 dynamic mitigation
In-Reply-To: <20180529121121.24927-8-marc.zyngier@arm.com>
References: <20180529121121.24927-1-marc.zyngier@arm.com>
 <20180529121121.24927-8-marc.zyngier@arm.com>
Message-ID: <9bd005f5-60e3-510d-24f6-235e98487ced@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/29/2018 08:11 AM, Marc Zyngier wrote:

> +void __init arm64_enable_wa2_handling(struct alt_instr *alt,
> +				      __le32 *origptr, __le32 *updptr,
> +				      int nr_inst)

Where does the name "wa2" come from here?

Jon.

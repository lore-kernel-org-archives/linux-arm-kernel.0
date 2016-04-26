From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 26 Apr 2016 14:11:43 +0100
Subject: linux-4.6-rc5/arch/arm/mach-vexpress/spc.c:332: possible typo ?
In-Reply-To: <DUB128-W495B590F6B8E0BF405721B9C620@phx.gbl>
References: <DUB128-W495B590F6B8E0BF405721B9C620@phx.gbl>
Message-ID: <571F690F.90109@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/04/16 21:31, David Binderman wrote:
> Hello there,
>
> linux-4.6-rc5/arch/arm/mach-vexpress/spc.c:332]: (style) Variable 'perf_stat_reg' is assigned a value that is never used.
>
>     if (cluster_is_a15(cluster)) {
>          req_type = CA15_DVFS;
>          perf_cfg_reg = PERF_LVL_A15;
>          perf_stat_reg = PERF_REQ_A15;
>      } else {
>          req_type = CA7_DVFS;
>          perf_cfg_reg = PERF_LVL_A7;
>          perf_stat_reg = PERF_REQ_A7;
>      }
>
> But local variable perf_stat_reg doesn't get used anywhere.
>
> Suggest either delete or use.
>

You are always welcome to post the patch especially after all your 
efforts to find it. Anyways I will post the patch for now.

-- 
Regards,
Sudeep

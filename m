From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 7 Jun 2018 14:08:56 +0530
Subject: [PATCH v5 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
In-Reply-To: <20180607074628.kd3iyxevwj3ypzbr@intel.com>
References: <1528186420-6615-3-git-send-email-changbin.du@intel.com>
 <201806060501.btF3aJMZ%fengguang.wu@intel.com>
 <20180606095714.1d3c2def@vmware.local.home>
 <20180606142600.GN13775@localhost>
 <20180606142622.2338abf6@vmware.local.home>
 <20180607041718.qpqucjzlvcm5h3gn@vireshk-i7>
 <20180607074628.kd3iyxevwj3ypzbr@intel.com>
Message-ID: <20180607083856.ealw62v3wx43zeqz@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07-06-18, 15:46, Du, Changbin wrote:
> I think if the destination is not a null terminated string (If I understand your
> description below), memcpy can be used to get rid of such warning. The warning
> makes sense in general as explained in mannual. Thanks!

The destination should be a null terminated string eventually, but we first need
to make sure src is a null terminated string.

-- 
viresh

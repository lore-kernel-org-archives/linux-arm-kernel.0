From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 7 Jul 2016 14:24:13 +0800
Subject: [PATCH V2 01/10] Documentation: dt-bindings: mailbox: tegra: Add
 binding for HSP mailbox
In-Reply-To: <577D39B6.701@wwwdotorg.org>
References: <20160705090431.5852-1-josephl@nvidia.com>
 <20160705090431.5852-2-josephl@nvidia.com> <577D39B6.701@wwwdotorg.org>
Message-ID: <577DF58D.4020901@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2016 01:02 AM, Stephen Warren wrote:
> On 07/05/2016 03:04 AM, Joseph Lo wrote:
>> Add DT binding for the Hardware Synchronization Primitives (HSP). The
>> HSP is designed for the processors to share resources and communicate
>> together. It provides a set of hardware synchronization primitives for
>> interprocessor communication. So the interprocessor communication (IPC)
>> protocols can use hardware synchronization primitive, when operating
>> between two processors not in an SMP relationship.
>
> Acked-by: Stephen Warren <swarren@nvidia.com>

Thanks,
-Joseph

> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

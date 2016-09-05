From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 5 Sep 2016 15:38:57 +0100
Subject: [PATCH] arm-cci: Fix typo in event name
In-Reply-To: <20160905143456.GD6826@leverpostej>
References: <1472828566-31533-1-git-send-email-suzuki.poulose@arm.com>
 <20160905143456.GD6826@leverpostej>
Message-ID: <13b34dcd-2c6c-338c-7c76-aea426dacaaf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/16 15:34, Mark Rutland wrote:
> On Fri, Sep 02, 2016 at 04:02:46PM +0100, Suzuki K Poulose wrote:
>> Fixes a typo in one of the event name for CCI
>
> Nit: s/name/names/
>
> Coudl you please expand the commit message to something like:
>
>   For one of the CCI events exposed under sysfs, "snoop" was typo'd as
>   "snopp". Correct this such that users see the expected event name when
>   enumerating events via sysfs.
>
> With that:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Sure, will do.

Thanks
Suzuki

From: girishks2000@gmail.com (Girish KS)
Date: Tue, 25 Jun 2013 10:05:29 +0530
Subject: [PATCH V2] ahci: sata: add support for exynos5440 sata
In-Reply-To: <20130617182446.GI32663@mtj.dyndns.org>
References: <1366104482-14240-1-git-send-email-ks.giri@samsung.com>
 <20130617182446.GI32663@mtj.dyndns.org>
Message-ID: <CAKrE-KdQCCW1jjkCyh03JWK4mjzSYRtcHcZCc7wi5-y3+CLOhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 11:54 PM, Tejun Heo <tj@kernel.org> wrote:
> On Tue, Apr 16, 2013 at 02:58:02PM +0530, Girish K S wrote:
>> This patch adds the compatible string of the exynos5440 sata controller
>> compliant with the ahci 1.3 and sata 3.0 specification.
>>
>> Signed-off-by: Girish K S <ks.giri@samsung.com>
>>
>> changes in v2:
>>               changed the compatible string by adding the actual IP
>> owners name instead of the SoC vendor name.
>
> Applied to libata/for-3.11.
>
> Can you please keep SOB at the end of the description after the
> revision history from the next time?

Sure. Thanks

>
> Thanks.
>
> --
> tejun

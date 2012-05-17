From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 17 May 2012 12:35:51 +0530
Subject: [PATCHv2 05/19] ARM: OMAP4: PM: save/restore all CM1/2 settings
 in OFF mode
In-Reply-To: <87zk977ne4.fsf@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-6-git-send-email-t-kristo@ti.com> <87zk977ne4.fsf@ti.com>
Message-ID: <CAMQu2gwFafCPUwGjexUrsV5TAFBwc6ZgwSSx_uPYuDU42rkG8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 4:18 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tero Kristo <t-kristo@ti.com> writes:
>
>> From: Rajendra Nayak <rnayak@ti.com>
>>
>> Restore all CM1/2 module registers as they are lost in OFF mode.
>
> Save and restore?
>
> Also, as in the previous patch. ?Can this be done using cluster PM
> notifier as well? ? ?(I realize that this series was probably done
> before the PM notifiers were upstream, but now that we have them, we
> should use them.)
>
Device OFF specific and not related to CPU cluster state as such.

Regards
Santosh

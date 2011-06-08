From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 8 Jun 2011 15:02:41 +0200
Subject: [Patch v2 09/11] ARM: perf: add PMUv2 common event definitions
In-Reply-To: <1307536233-30089-10-git-send-email-will.deacon@arm.com>
References: <1307536233-30089-1-git-send-email-will.deacon@arm.com>
	<1307536233-30089-10-git-send-email-will.deacon@arm.com>
Message-ID: <BANLkTik-ms3r-+VSAw2vSDGKqO+31xwghw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Wed, Jun 8, 2011 at 2:30 PM, Will Deacon <will.deacon@arm.com> wrote:
> The PMUv2 specification reserves a number of event encodings
> for common events.
>
> This patch adds these events to the common event enumeration
> in preparation for PMUv2 cores, such as Cortex-A15.
>
> Cc: Jean Pihet <jean.pihet@newoldbits.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

The change looks good, here is the acked-by FWIW:
Signed-off-by: Jean Pihet <j-pihet@ti.com>

...

Regards,
Jean

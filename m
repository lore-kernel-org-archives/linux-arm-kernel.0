From: dp@opensource.wolfsonmicro.com (Dimitris Papastamos)
Date: Fri, 2 Nov 2012 13:02:02 +0000
Subject: [PATCH] ARM: S3C64XX: Fix up IRQ mapping for balblair on
 Cragganmore
In-Reply-To: <5093B962.1060903@mvista.com>
References: <1351852733-3346-1-git-send-email-dp@opensource.wolfsonmicro.com>
 <5093B962.1060903@mvista.com>
Message-ID: <20121102130202.GA21340@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 02, 2012 at 04:15:30PM +0400, Sergei Shtylyov wrote:
> Hello.
>
> On 02-11-2012 14:38, Dimitris Papastamos wrote:
>
>> We are using S3C_EINT(4) instead of S3C_EINT(5).
>
>> Change-Id: Ia197069ddc736813f2711c763469eaf655ea58ac
>
>    Remove this line please -- it has no place in the upstream patch.
>
>> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
>
> WBR, Sergei
>

Oops, thanks for catching that.

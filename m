From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Mon, 6 Aug 2012 15:29:38 +0200
Subject: [PATCHv7 06/12] ARM: OMAP4: suspend: Program all domains to
 retention
In-Reply-To: <500816BB.3090809@mvista.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
 <1342704392-23657-7-git-send-email-t-kristo@ti.com>
 <500816BB.3090809@mvista.com>
Message-ID: <CAORVsuWvWDcK5fxGmXmbaHZQ48utRv6FoS2cOrYcP_8eFOLiBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Thu, Jul 19, 2012 at 4:16 PM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
> On 07/19/2012 05:26 PM, Tero Kristo wrote:
>
>> From: Rajendra Nayak <rnayak@ti.com>
>
>> Remove the FIXME's in the suspend sequence since
>> we now intend to support system level RET support.
>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> [Jean Pihet <j-pihet@ti.com>: ported on top of the functional power
>> states]
>
>   Shouldn't Jean also have signed off?
Sure! I am OK with this change, feel free to add:
Acked-by: Jean Pihet <j-pihet@ti.com>

Regards,
Jean

>
>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> WBR, Sergei
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 15 Dec 2016 18:59:28 +0900
Subject: [PATCH] ARM: dts: r8a7791: link DU to VSPDs
In-Reply-To: <1922293.x1RvWWSErN@wasted.cogentembedded.com>
References: <1529351.Fac5N2tKoF@wasted.cogentembedded.com>
 <1922293.x1RvWWSErN@wasted.cogentembedded.com>
Message-ID: <CANqRtoRg6RxnqQAmuqFw1sjC6+zUUKR+6cBt9tkCOnR-d06OhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Thu, Dec 15, 2016 at 7:07 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Add the "vsps" property to the DU device node in order to link this node to
> the VSPD nodes.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
> This patch is against the 'renesas-devel-20161212-v4.9' of Simon Horman's
> 'renesas.git' repo.  It's  only meaningful if the DU driver patch I've just
> posted is applied.

Next time, please consider pointing out the exact name of the patch
you are referring to.

Thanks,

/ magnus

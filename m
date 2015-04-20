From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Mon, 20 Apr 2015 10:37:39 -0500
Subject: [trivial PATCH] arm: dts: socfpga: Remove executable permission
 bits
In-Reply-To: <CAL_Jsq+VN15c-LE_iQzx1AnoPWmNEtjVgiEBb2OkHQPP=ZrQMQ@mail.gmail.com>
References: <1429224565.2850.62.camel@perches.com>
 <CAL_Jsq+VN15c-LE_iQzx1AnoPWmNEtjVgiEBb2OkHQPP=ZrQMQ@mail.gmail.com>
Message-ID: <CADhT+wf4UY+N+k9BLk5WcGd5czjo8CK86ocDoCPMDVjzLGay2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,

On Thu, Apr 16, 2015 at 5:54 PM, Rob Herring <robherring2@gmail.com> wrote:
> +arm-soc
>
> On Thu, Apr 16, 2015 at 5:49 PM, Joe Perches <joe@perches.com> wrote:
>> Change the .dts file permissions from 755 to 644.
>>
>> Signed-off-by: Joe Perches <joe@perches.com>
>
> ARM dts files go in thru arm-soc tree.
>
> Acked-by: Rob Herring <robh@kernel.org>
>

Thanks for doing this, but this patch:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-April/335418.html

should address the same issue.

Thanks,
Dinh

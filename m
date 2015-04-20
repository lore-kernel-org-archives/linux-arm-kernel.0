From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Mon, 20 Apr 2015 13:58:15 -0500
Subject: [trivial PATCH] arm: dts: socfpga: Remove executable permission
 bits
In-Reply-To: <1429544704.4216.39.camel@perches.com>
References: <1429224565.2850.62.camel@perches.com>
 <CAL_Jsq+VN15c-LE_iQzx1AnoPWmNEtjVgiEBb2OkHQPP=ZrQMQ@mail.gmail.com>
 <CADhT+wf4UY+N+k9BLk5WcGd5czjo8CK86ocDoCPMDVjzLGay2w@mail.gmail.com>
 <1429544704.4216.39.camel@perches.com>
Message-ID: <CADhT+wec-yRrreOxbcGpL9uRQDuq16B2CT7yMYNLp70LEBubZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 20, 2015 at 10:45 AM, Joe Perches <joe@perches.com> wrote:
> On Mon, 2015-04-20 at 10:37 -0500, Dinh Nguyen wrote:
>> On Thu, Apr 16, 2015 at 5:54 PM, Rob Herring <robherring2@gmail.com> wrote:
>> > +arm-soc
>> > On Thu, Apr 16, 2015 at 5:49 PM, Joe Perches <joe@perches.com> wrote:
>> >> Change the .dts file permissions from 755 to 644.
>> >> Signed-off-by: Joe Perches <joe@perches.com>
>> > ARM dts files go in thru arm-soc tree.
>> > Acked-by: Rob Herring <robh@kernel.org>
>> Thanks for doing this, but this patch:
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-April/335418.html
>> should address the same issue.
>
> That's fine with me.
> This patch is not in -next yet though.
> Is someone going to apply/push/pull it?
>

I need to send a v2 for this patch series, and I'll send a pull
request to arm-soc once it's been reviewed.

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-April/338273.html

Thanks,
Dinh

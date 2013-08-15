From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 15 Aug 2013 08:44:56 -0700
Subject: [PATCH v6 2/4] ARM: debug: support debug ll on hisilicon soc
In-Reply-To: <CAOesGMhyv6oT3Mk48NHPz-s8XSWhrE7_ig5qpB1vQW2x9c4GhA@mail.gmail.com>
 (Olof Johansson's message of "Wed, 14 Aug 2013 16:03:44 -0700")
References: <1374813135-16238-1-git-send-email-haojian.zhuang@linaro.org>
 <1374813135-16238-3-git-send-email-haojian.zhuang@linaro.org>
 <20130814063916.GH19951@quad.lixom.net>
 <20130814154443.GV23006@n2100.arm.linux.org.uk>
 <20130814162502.GA16491@quad.lixom.net>
 <20130814225428.GB23006@n2100.arm.linux.org.uk>
 <CAOesGMhyv6oT3Mk48NHPz-s8XSWhrE7_ig5qpB1vQW2x9c4GhA@mail.gmail.com>
Message-ID: <87ioz7m007.fsf@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson <olof@lixom.net> writes:

> On Wed, Aug 14, 2013 at 3:54 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
[...]

>> CONFLICT (delete/modify): arch/arm/include/debug/highbank.S deleted
>> in HEAD and modified in arm-soc/for-next. Version arm-soc/for-next
>> of arch/arm/include/debug/highbank.S left in tree.
>>
>> which seems to be a change in the virtual address of the port.  This
>> one is particularly nasty because it needs to be moved to a completely
>> different file and therefore is not git rerere'able.  Does it have any
>> dependencies?
>
> I don't think so, we can likely move that patch over to your tree
> instead and drop it from arm-soc.

The highbank change is now dropped from arm-soc and needs to be be
rebased/reworked on your tree.

Kevin

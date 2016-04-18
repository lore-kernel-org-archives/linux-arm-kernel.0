From: b.hutchman@gmail.com (Brian Hutchinson)
Date: Mon, 18 Apr 2016 15:19:19 -0400
Subject: Appended DTB with 4.4 and 4.6
In-Reply-To: <CAOd_LFxTnJoHmKabSmoo5LhzJ+KCiFLa1x4NFRt7JzRUyZi1gQ@mail.gmail.com>
References: <CAOd_LFxTnJoHmKabSmoo5LhzJ+KCiFLa1x4NFRt7JzRUyZi1gQ@mail.gmail.com>
Message-ID: <CAFZh4h_2G2+dLe4uhGP8BRtq+XaX0jZE1RYEPZQgCH24HLV0zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2016 at 3:11 PM, Cliff Brake <cliff.brake@gmail.com> wrote:
> Hi,
>
> We've been using CONFIG_ARM_APPENDED_DTB to append a DTB to a uImage
> successfully with 4.1.  However, tried with 4.4 and 4.6 and can't get
> bb-xm to boot with appended DTB.  If I load DTB via BL, the 4.4/4.6
> kenels work fine.
>
> Has anyone else been using kernels in the 4.4 to 4.6 range with appended DTB?
>
> Thanks,
> Cliff
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Yes, but with TI 816x.  Using 4.2.3 and 4.4.1.

Regards,

Brian

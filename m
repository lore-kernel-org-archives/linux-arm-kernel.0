From: cliff.brake@gmail.com (Cliff Brake)
Date: Mon, 18 Apr 2016 15:11:00 -0400
Subject: Appended DTB with 4.4 and 4.6
Message-ID: <CAOd_LFxTnJoHmKabSmoo5LhzJ+KCiFLa1x4NFRt7JzRUyZi1gQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

We've been using CONFIG_ARM_APPENDED_DTB to append a DTB to a uImage
successfully with 4.1.  However, tried with 4.4 and 4.6 and can't get
bb-xm to boot with appended DTB.  If I load DTB via BL, the 4.4/4.6
kenels work fine.

Has anyone else been using kernels in the 4.4 to 4.6 range with appended DTB?

Thanks,
Cliff

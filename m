From: olof@lixom.net (Olof Johansson)
Date: Mon, 2 Dec 2013 09:22:05 -0800
Subject: [PATCH] ARM: multi_v7_defconfig: enable network for BeagleBone
 Black
In-Reply-To: <20131202160938.GH23334@atomide.com>
References: <1385972129-3638-1-git-send-email-olof@lixom.net>
 <20131202160938.GH23334@atomide.com>
Message-ID: <CAOesGMhE6jvgumbnS9Y0DzwfViBZhiVa3OnPY-wm9c6O1WQU-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 2, 2013 at 8:09 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Olof Johansson <olof@lixom.net> [131202 00:15]:
>> BeagleBone Black uses the TI CPSW ethernet controller, enable it in the
>> multi_v7_defconfig for testing coverage purposes.
>>
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>
> Acked-by: Tony Lindgren <tony@atomide.com>

Thanks.

Applied to fixes. Marked for stable 3.12 as well.


-Olof

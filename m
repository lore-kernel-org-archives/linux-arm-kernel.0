From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 22 May 2014 09:37:40 +0900
Subject: [PATCH v3] clk: shmobile: Add R8A7740-specific clock support
In-Reply-To: <1768296.AYVfH6xHtk@avalon>
References: <1400682086-5705-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1768296.AYVfH6xHtk@avalon>
Message-ID: <CANqRtoQtPnUcGCg4X9UuNoA6pg6Vd7HWfo30LqD1LOUi+5VC-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Thu, May 22, 2014 at 12:41 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wednesday 21 May 2014 16:21:26 Ulrich Hecht wrote:
>> Driver for the R8A7740's clocks that are too specific to be supported by a
>> generic driver.
>>
>> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
>
> The implementation looks globally sane to me. There's still quite a few
> missing clocks, but there's no hurry in adding support for them at the moment.
> I'd like to get the bindings reviewed by someone outside of our team, but that
> would require making the CPG documentation (or at least the block diagram)
> available. Magnus, is there a chance for that to happen ?

Regarding documentation, as much as I'd like to see this, in practice
it feels highly unlikely since I'm not in control of the actual data
sheet distribution policy. I believe Emma Mobile series data sheet are
available for public download, but the rest of the SoCs are not
unfortunately.

This issue with closed documentation is not specific to r8a7740
though, so earlier developed CCF implementations included in upstream
like r8a7790, r8a7791, r7s72100 and r8a7779 are in the same state as
r8a7740.

Thanks,

/ magnus

From: leoli@freescale.com (Li Yang)
Date: Fri, 4 Sep 2015 16:12:59 -0500
Subject: [PATCH v2 03/10] Documentation/dts: Add bindings for QIXIS FPGA
 controller found on FSL boards
In-Reply-To: <BY1PR0301MB1303E56B5462BCD0C77C7E4D82570@BY1PR0301MB1303.namprd03.prod.outlook.com>
References: <1441349872-4560-1-git-send-email-bhupesh.sharma@freescale.com>
 <1441349872-4560-4-git-send-email-bhupesh.sharma@freescale.com>
 <CADRPPNR11BD4WfXTWoQ28rZCd_BJuhdWu49E6jjpO29CH2s5Ow@mail.gmail.com>
 <BY1PR0301MB1303E56B5462BCD0C77C7E4D82570@BY1PR0301MB1303.namprd03.prod.outlook.com>
Message-ID: <CADRPPNQFxqNqgvrL9eVhaDX-SYRJxmGDd87zu_XHDHY6afiu3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 4, 2015 at 3:16 PM, Sharma Bhupesh
<bhupesh.sharma@freescale.com> wrote:
>> From: pku.leo at gmail.com [mailto:pku.leo at gmail.com]
>> Sent: Friday, September 04, 2015 10:27 PM
>> On Fri, Sep 4, 2015 at 1:57 AM, Bhupesh Sharma
>> <bhupesh.sharma@freescale.com> wrote:
>> > This patch adds bindings for QIXIS FPGA controller found on FSL boards.
>>
>> A general comment: when you are updating the device tree bindings.
>> You should cc the devicetree at vger.kernel.org mailing list.
>>
>> >
>> > Some Freescale boards like LS2080AQDS/LS2080ARDB have an on-board
>> > FPGA/CPLD connected to the IFC controller. The bindings specified in
>> > this patch cater to those on-board FPGA/CPLD controllers.
>>
>> We already have the binding defined in
>> Documentation/devicetree/bindings/powerpc/fsl/board.txt.  We probably
>> should just move it to a more generic location.
>
> Consolidation of powerpc and ARM bindings is something that needs to be
> targeted by a separate patch-series, perhaps in future.
>
> There are a number of duplications that can be looked into, but I don't
> think this patchset should depend on that.

There might be some duplication, but we shouldn't be adding more.  :)
I would rather you directly updating that file than creating a new
file even though the original one was in a wrong directory.

Regards,
Leo

From: leoli@freescale.com (Li Yang)
Date: Fri, 4 Sep 2015 11:56:54 -0500
Subject: [PATCH v2 03/10] Documentation/dts: Add bindings for QIXIS FPGA
 controller found on FSL boards
In-Reply-To: <1441349872-4560-4-git-send-email-bhupesh.sharma@freescale.com>
References: <1441349872-4560-1-git-send-email-bhupesh.sharma@freescale.com>
 <1441349872-4560-4-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <CADRPPNR11BD4WfXTWoQ28rZCd_BJuhdWu49E6jjpO29CH2s5Ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 4, 2015 at 1:57 AM, Bhupesh Sharma
<bhupesh.sharma@freescale.com> wrote:
> This patch adds bindings for QIXIS FPGA controller found on FSL boards.

A general comment: when you are updating the device tree bindings.
You should cc the devicetree at vger.kernel.org mailing list.

>
> Some Freescale boards like LS2080AQDS/LS2080ARDB have an on-board FPGA/CPLD
> connected to the IFC controller. The bindings specified in this patch
> cater to those on-board FPGA/CPLD controllers.

We already have the binding defined in
Documentation/devicetree/bindings/powerpc/fsl/board.txt.  We probably
should just move it to a more generic location.

Regards,
Leo

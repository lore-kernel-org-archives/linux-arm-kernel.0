From: jason77.wang@gmail.com (Jason Wang)
Date: Sat, 12 Jun 2010 22:22:35 +0800
Subject: [PATCH 0/4]Refine iomux files for i.MX51
Message-ID: <1276352559-8105-1-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Through the discussion, I divide my patches to 3 parts.
part1: mx51 iomux related part, the first patch in this part is from
       Amit, other patches are based off this patch and they are some
       fix or adding definitions for imx51_3ds board.
part2: mxc common cpld debugboard patches. In this part, include a
       reverting mx31_3ds patch. I have made built and bootup test
       for mx31_3ds platform.
part3: adding mx51_3ds platform patches.

Because part3 depends on part1 and part2, while part1 and part2 are
independent mutually, i will send part1 and part2 first, if these
two parts are passed review, then i will send part3.

part1:
 [PATCH 1/4] mxc: Fix pad names for imx51
 [PATCH 2/4] mx51/iomux: Fix mux mode and input path for two pads
 [PATCH 3/4] mx51/iomux: add UART and GPIO pad definitions for imx51_3ds board
 [PATCH 4/4] mxc/iomux: add GPIO bank offset for iomux v3 platforms

part2:
 [PATCH 1/2] mxc: add common debug board for 3-stack platforms
 [PATCH 2/2] mx31_3ds: revert cpld debug board relate code

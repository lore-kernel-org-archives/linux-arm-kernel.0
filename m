From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Thu, 18 Jun 2015 21:43:04 +0530
Subject: [PATCH v2 0/7] fix build failure of mn10300
In-Reply-To: <20150618145138.GN7557@n2100.arm.linux.org.uk>
References: <1434629873-11668-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20150618145138.GN7557@n2100.arm.linux.org.uk>
Message-ID: <20150618161304.GA21198@sudip-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 03:51:38PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 18, 2015 at 05:47:46PM +0530, Sudip Mukherjee wrote:
> > This is an attempt to fix the build failures when building mn10300 with
> > allmodconfig. As I have never worked with arch files so I hope you will
> > point me to right direction to correct my mistakes in this attempt.
> 
> Why has the linux-arm-kernel mailing list been copied for something
> which clearly has nothing to do with ARM?  Am I missing something
> in this series?
get_maintainer.pl is giving linux-arm-kernel mailing list for
patch 3/7 ("mmc: mediatek: build as module").

regards
sudip

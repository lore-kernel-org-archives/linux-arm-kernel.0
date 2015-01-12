From: olof@lixom.net (Olof Johansson)
Date: Mon, 12 Jan 2015 14:00:57 -0800
Subject: [GIT PULL] Xilinx Zynq dt fixes for v3.19
In-Reply-To: <54AE44AF.6010808@monstr.eu>
References: <544519A4.5090003@monstr.eu>
 <54AE44AF.6010808@monstr.eu>
Message-ID: <20150112220057.GA22090@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 08, 2015 at 09:49:51AM +0100, Michal Simek wrote:
> Hi,
> 
> please consider to pull this one DT patch to your tree as fix for v3.19
> It is adding USD dt node. Driver has been added to v3.19.
> 
> Thanks,
> Michal
> 
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> 
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> 
> are available in the git repository at:
> 
>   https://github.com/Xilinx/linux-xlnx.git tags/zynq-dt-fixes-for-3.19
> 
> for you to fetch changes up to 1643b31658c44767a85469733c6bff4f6d0371c7:
> 
>   ARM: zynq: DT: Add USB to device tree (2015-01-08 09:35:04 +0100)

Michal,

This isn't really a fix for something that is broken, is it? I.e. looks like
new hardware support to me, and unfortunately this time in the release is wrong
for that.

I'd be happy to queue it up for 3.20 though, so please confirm.


Thanks!

-Olof

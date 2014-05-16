From: olof@lixom.net (Olof Johansson)
Date: Fri, 16 May 2014 16:08:10 -0700
Subject: [GIT PULL] SOCFPGA DTS updates for 3.16, v3
In-Reply-To: <1399348285-6757-1-git-send-email-dinguyen@altera.com>
References: <1399348285-6757-1-git-send-email-dinguyen@altera.com>
Message-ID: <20140516230810.GC6028@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 05, 2014 at 10:51:25PM -0500, dinguyen at altera.com wrote:
> Hi Arnd, Kevin and Olof,
> 
> Please consider pulling in these patches for v3.16. This is version 3 of the
> original SOCFPGA DTS pull request for v3.16. This new tag omits the following
> patches:
> 
> ARM: dts: socfpga: add gpio pieces -> Pending further discussion.
> dt: bindings: Typo s/clocks-names/clock-names/g -> Already in Grant Likely's tree.
> 
> Also removes the artifact from a rebase that occurred in v2. So sorry about that.
> I have also compile tested this tag.
> 
> Thanks,
> 
> The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:
> 
>   Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)
> 
> are available in the git repository at:
> 
>   git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga-dt-updates-for-3.16_v3
> 
> for you to fetch changes up to 8cb289ed60668d3350dda5aa19b4fa1dce1c07f1:
> 
>   ARM: socfpga: dts: Add div-reg to the main_pll clocks (2014-05-05 22:33:18 -0500)

Merged, thanks. Apologies for the delay.

-Olof

From: olof@lixom.net (Olof Johansson)
Date: Sun, 19 Oct 2014 13:51:16 -0700
Subject: [GIT PULL] qcom DT changes for v3.18-3
In-Reply-To: <FBA74704-E00F-4CD5-A07C-56B72F6755DA@codeaurora.org>
References: <FBA74704-E00F-4CD5-A07C-56B72F6755DA@codeaurora.org>
Message-ID: <20141019205116.GB10595@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 16, 2014 at 10:03:48AM +0200, Kumar Gala wrote:
> The following changes since commit aabff7bfe55afd01d71a5f11d4a84bd873c20f5e:
> 
>   ARM: DT: msm8960: Add sdcc nodes (2014-09-22 13:49:43 -0500)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git tags/qcom-dt-for-3.18-3
> 
> for you to fetch changes up to 7dac24bdc1dd561573cd8ce534a63dc975f51ca8:
> 
>   ARM: dts: qcom: add CM-QS600 board (2014-10-16 02:48:36 -0500)
> 
> ----------------------------------------------------------------
> Qualcomm ARM Based Device Tree Updates for v3.18-3
> 
> * Added Board support for CM-QS600 and Sony Xperia Z1 phone
> * Added SATA support on IPQ8064/AP148

In general we try to avoid merging all that much dt contents late,
but since Kevin wanted the Xperia stuff added I've merged this in now.


-Olof

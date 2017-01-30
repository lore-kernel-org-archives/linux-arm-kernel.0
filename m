From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 16:26:44 -0800
Subject: [GIT PULL] Qualcomm SoC Updates for v4.11
In-Reply-To: <1485240752-8339-1-git-send-email-andy.gross@linaro.org>
References: <1485240752-8339-1-git-send-email-andy.gross@linaro.org>
Message-ID: <20170130002644.GP3133@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 12:52:32AM -0600, Andy Gross wrote:
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-soc-for-4.11
> 
> for you to fetch changes up to aabde95fc543a9ca68df06b9c7ea8e699702d7ad:
> 
>   firmware: qcom: scm: Fix interrupted SCM calls (2017-01-23 10:01:49 -0600)
> 
> ----------------------------------------------------------------
> Qualcomm ARM Based SoC Updates for v4.11
> 
> * Add SMCC quirk support
> * Add Qualcomm SCM quirk to fix interrupted calls

Hi,

I replied on one of the patches. Not sure doing this through quirks is the
right way right now -- unless we expect a lot more quirks over time, and/or if
this is an "enhancement" that other vendors are also likely to pick up.


-Olof

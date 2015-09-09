From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 09 Sep 2015 12:14:35 -0700
Subject: [GIT PULL] qcom dt changes for 4.3-rc2
In-Reply-To: <1440710941-29302-1-git-send-email-agross@codeaurora.org> (Andy
 Gross's message of "Thu, 27 Aug 2015 16:29:01 -0500")
References: <1440710941-29302-1-git-send-email-agross@codeaurora.org>
Message-ID: <7hsi6nl810.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

Andy Gross <agross@codeaurora.org> writes:

> The following changes since commit 4040f37692ffbc602117d316c574a68a0fbfed93:
>
>   Merge tag 'qcom-dt-for-4.3' into for-dt (2015-08-27 12:07:21 -0500)
>
> are available in the git repository at:
>
>
>   git://codeaurora.org/quic/kernel/agross-msm.git tags/qcom-dt-for-4.3-rc2
>
> for you to fetch changes up to cecd36b9c847b451e8ae297b53b094445b5352e4:
>
>   ARM: dts: qcom: msm8974-sony-xperia-honami: Use stdout-path (2015-08-27 12:11:22 -0500)
>
> ----------------------------------------------------------------

Can you respin this on v4.2-rc2?  Your current branch is on -rc8, which
causes some conflicts with other drivers/cpufreq stuff we have in the
late branch.

Similar request for your soc branch.

Kevin

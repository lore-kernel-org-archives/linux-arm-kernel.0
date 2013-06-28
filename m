From: olof@lixom.net (Olof Johansson)
Date: Thu, 27 Jun 2013 17:06:21 -0700
Subject: [GIT PULL v2] msm clock for 3.11
In-Reply-To: <1372107629-25862-1-git-send-email-davidb@codeaurora.org>
References: <20130614195238.GA2381@codeaurora.org>
 <1372107629-25862-1-git-send-email-davidb@codeaurora.org>
Message-ID: <20130628000621.GA11547@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 02:00:28PM -0700, David Brown wrote:
> This pull request differs from the previous one for the clock code by:
> 
>   - Gathered additional Acked-by lines.
>   - A small #include fixup found by Stephen Boyd
> 
> The only Ack not received was from Chris Ball, who is CC'd on this
> request.
> 
> The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:
> 
>   Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm.git tags/msm-clock-for-3.11b

Thanks, pulled into next/late. This conflicts with a fixes-non-critical
fix to removed code, trivially resolved.


-Olof

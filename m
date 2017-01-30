From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 21:01:28 -0800
Subject: [GIT PULL] STi DT update for v4.11 round 2
In-Reply-To: <19365aed-8db8-f3cb-02b6-f0e3ef557d37@st.com>
References: <f5af2119-21ac-7116-5109-1a8837f87cfb@st.com>
 <b03b0db3-6f86-aa53-c485-4291f8459983@st.com>
 <19365aed-8db8-f3cb-02b6-f0e3ef557d37@st.com>
Message-ID: <20170130050128.GJ18943@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 05:15:32PM +0000, Patrice CHOTARD wrote:
> Here is the correct one
> 
> PLease consider this second round of STi dts update for v4.11 :
> 
> The following changes since commit 2016ead446b98c42dffd9b6c03ce813e5cb3b810:
> 
>    ARM: dts: STiH407-family: Supply Mailbox properties to delta RProc 
> (2017-01-12 17:23:39 +0100)
> 
> are available in the git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git 
> sti-dt-for-v4.11-round2
> 
> for you to fetch changes up to c58736c160c1346bedda77d739f0f85710fa00cf:
> 
>    ARM: dts: STiH407-family: Add missing pwm irq (2017-01-27 17:34:03 +0100)
> 
> ----------------------------------------------------------------
> 
> STi DT fix:
> 
> Add missing interrupt node to properly probe the pwm device.

Merged, thanks!


-Olof

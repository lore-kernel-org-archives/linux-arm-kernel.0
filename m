From: viresh.linux@gmail.com (viresh kumar)
Date: Sat, 19 Feb 2011 22:50:13 +0530
Subject: [PATCH V5 15/63] ST SPEAr: Correcting SOC Config base address for
	spear320
In-Reply-To: <20110219164020.GM29493@n2100.arm.linux.org.uk>
References: <cover.1295499392.git.viresh.kumar@st.com>
	<cac5d194ea4be06a5a10dcf8059e87426ae1ee9d.1295499394.git.viresh.kumar@st.com>
	<20110219164020.GM29493@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=bWPYaEyRMujLChAdGPNqCYXRoAKMgVqptLffD@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/19/11, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Thu, Jan 20, 2011 at 12:55:54PM +0530, Viresh Kumar wrote:
>> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
>
> This looks to me like another bug fix, and I'm treating it as such.  It
> should be submitted separately from this patch set along with other bug
> fixes, and clearly labelled as such.
>

Yes it is a bug fix and should have been submitted separately.

> I've also changed the comments on this patch to:
>
> "SPEAr: Correct SOC config base address for spear320
>
> SPEAR320_SOC_CONFIG_BASE was wrong, causing the wrong registers to be
> accessed."
>

Thanks for your help. Will take care of commit message next time.

--
viresh

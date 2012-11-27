From: deepak.sikri@st.com (Deepak Sikri)
Date: Tue, 27 Nov 2012 09:46:43 +0530
Subject: [PATCH] cpufreq: SPEAr: Add CPUFreq driver
In-Reply-To: <CAKohpomSAogQVeBQ8HaWwwoTVCsMha5d_1Wid6N3t5SnVZTc=w@mail.gmail.com>
References: <7ec0e3f4b81b70f3def4257e6b9781efd4c7a3d2.1353785862.git.viresh.kumar@linaro.org>
 <20121127040135.GB27305@S2100-06.ap.freescale.net>
 <CAKohpomSAogQVeBQ8HaWwwoTVCsMha5d_1Wid6N3t5SnVZTc=w@mail.gmail.com>
Message-ID: <50B43EAB.80602@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/2012 9:28 AM, Viresh Kumar wrote:
>>> [snip..]
>>> It's a little bit unusual that cpu runs such a freq range
>>> (166 ~ 600 MHz) at a fixed voltage.  You really have no way
>>> to scale voltage?
> AFAIK, there is no voltage scaling.
>
> @Shiraz/Deepak: Can you confirm?

We do not have any provision for voltage scaling in SPEAr.

Deepak

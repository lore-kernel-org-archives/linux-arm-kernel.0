From: viresh.kumar@st.com (viresh kumar)
Date: Mon, 25 Apr 2011 16:29:25 +0530
Subject: [PATCH V4 resend] rtc: Adding support for spear rtc
In-Reply-To: <6bd0f375a2f9475172a3ea968b0662b7c73da421.1297247552.git.viresh.kumar@st.com>
References: <6bd0f375a2f9475172a3ea968b0662b7c73da421.1297247552.git.viresh.kumar@st.com>
Message-ID: <4DB5540D.9050204@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/2011 04:06 PM, Viresh KUMAR wrote:
> From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
> 
> Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/rtc/Kconfig     |    8 +
>  drivers/rtc/Makefile    |    1 +
>  drivers/rtc/rtc-spear.c |  534 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 543 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/rtc/rtc-spear.c
> 

Russell,

We have been waiting for response from rtc's mailing list from a very long time,
but didn't got any feedback till date.
As this driver is specific to SPEAr, can we get this added through arm's tree??

--
viresh

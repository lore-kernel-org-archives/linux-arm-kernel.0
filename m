From: viresh.linux@gmail.com (viresh kumar)
Date: Wed, 7 Mar 2012 04:11:27 -0800
Subject: [PATCH 10/15] watchdog/mpcore_wdt: Add support for dev_pm_ops
 interface
In-Reply-To: <4F5748CC.9020601@ru.mvista.com>
References: <cover.1331115751.git.viresh.kumar@st.com>
 <b50542be97df8b90d3e7c696a8d13be707f581f9.1331115752.git.viresh.kumar@st.com>
 <4F5748CC.9020601@ru.mvista.com>
Message-ID: <CAOh2x=mvuFyG3Gg-rdU23hz2TyHNM=u2JWn2uiONuKUEUY3GnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/7/12, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> On 07-03-2012 14:27, Viresh Kumar wrote:

>>   static struct platform_driver mpcore_wdt_driver = {

>>   	.driver		= {
>>   		.owner	= THIS_MODULE,
>>   		.name	= "mpcore_wdt",
>> +		.pm = &mpcore_wdt_dev_pm_ops,
>
>     Please align the right part of initializer like all above.
>
> WBR, Sergei
>

Sure.

--
viresh

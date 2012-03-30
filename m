From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 30 Mar 2012 09:31:11 +0530
Subject: [RFC] pinctrl: Replace list_groups() with get_groups_count()
In-Reply-To: <4F74A05E.7050803@wwwdotorg.org>
References: <CAOh2x==LTHPM+O9LXVFVdX2NfzKs2bttiYLm8VcL6qLXKrUMBg@mail.gmail.com>
 <4F749B58.4070608@wwwdotorg.org>
 <CAOh2x==mGDZRoxdbuvbhKtfoxiEDVb+7vdfBEYD=u+DdMCYVhw@mail.gmail.com>
 <4F74A05E.7050803@wwwdotorg.org>
Message-ID: <4F753007.2030707@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/29/2012 11:18 PM, Stephen Warren wrote:
>>> >> I vaguely recall raising the same issue before, and Linus saying he
>>> >> wanted to be consistent with similar list_*() functions in other
>>> >> subsystems, but personally I'd prefer to evaluate this aspect of the
>>> >> pinctrl subsystem on its own.
>> > 
>> > Which other subsystems have such stuff?
> For example. include/linux/regulator/driver.h struct regulator_ops field
> list_voltage().

Thanks.

Anyway, if others implement it, that doesn't mean we also do that, even
if we are not happy with it. It is not only about cleaning of code, but
it will save boot time too.

@Linus: Can i have your viewpoint before i start doing this?

-- 
viresh

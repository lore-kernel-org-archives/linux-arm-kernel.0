From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 29 Mar 2012 11:48:14 -0600
Subject: [RFC] pinctrl: Replace list_groups() with get_groups_count()
In-Reply-To: <CAOh2x==mGDZRoxdbuvbhKtfoxiEDVb+7vdfBEYD=u+DdMCYVhw@mail.gmail.com>
References: <CAOh2x==LTHPM+O9LXVFVdX2NfzKs2bttiYLm8VcL6qLXKrUMBg@mail.gmail.com>	<4F749B58.4070608@wwwdotorg.org>
 <CAOh2x==mGDZRoxdbuvbhKtfoxiEDVb+7vdfBEYD=u+DdMCYVhw@mail.gmail.com>
Message-ID: <4F74A05E.7050803@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2012 11:31 AM, viresh kumar wrote:
> On Mar 29, 2012 10:56 PM, Stephen Warren wrote:
>> On 03/29/2012 10:34 AM, viresh kumar wrote:
...
>> I vaguely recall raising the same issue before, and Linus saying he
>> wanted to be consistent with similar list_*() functions in other
>> subsystems, but personally I'd prefer to evaluate this aspect of the
>> pinctrl subsystem on its own.
> 
> Which other subsystems have such stuff?

For example. include/linux/regulator/driver.h struct regulator_ops field
list_voltage().

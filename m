From: ta.omasab@gmail.com (Thomas Abraham)
Date: Wed, 14 May 2014 19:19:18 +0530
Subject: [PATCH v3 1/2] cpufreq / OPP: Allow boost frequency to be looked
 up from device tree
In-Reply-To: <CAKohponG9PNse4cHkvfLfaRouW-jxjToBXUCHyOCgx8-Pc=2Xw@mail.gmail.com>
References: <1400029380-5372-1-git-send-email-thomas.ab@samsung.com>
 <1400029380-5372-2-git-send-email-thomas.ab@samsung.com>
 <CAKohponnPSRAotJUu+5a9y8j97QF8Jqgc5DA5WQnwGWCnVY-aA@mail.gmail.com>
 <CAGo_u6p-uqw82ewDciDEhAt0=Nswfw33-gf8Aa+-6_k3eCcTzw@mail.gmail.com>
 <20140514080930.781e0557@amdc2363>
 <CAKohponG9PNse4cHkvfLfaRouW-jxjToBXUCHyOCgx8-Pc=2Xw@mail.gmail.com>
Message-ID: <CAJuA9ah8e9fqK1yEDad2TbFsrixc66tW0CzPsU99L5RnQ_KFwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 14, 2014 at 11:54 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 14 May 2014 11:39, Lukasz Majewski <l.majewski@samsung.com> wrote:
>> I agree with Nishanth here, that point 1 (as described by Viresh at
>> [*]) is a more scalable approach.
>
> The only reason why I wanted all that to be done at OPP level was to
> ensure if somebody else also needs it apart from cpufreq, they don't have
> to duplicate code and find it.. As it is present at a central place..
>
> But if no other code is going to look for that, it may just be fine as is..

Yes, I agree with Nishanth and Lukasz for a separate binding.
